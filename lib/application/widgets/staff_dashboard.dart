import 'package:cmu_fondue/application/pages/area_problems_map_page.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/application/widgets/filters_section.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  bool _isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // โหลดปัญหาทั้งหมดมาไว้ที่เดียวผ่าน Provider
    await context.read<ProblemProvider>().fetchProblems();
    if (mounted) setState(() => _isInitialLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer<ProblemProvider>(
      builder: (context, provider, child) {
        final filteredList = provider.filteredProblems;
        final stats = provider.getLocalStatistics();

        final mostUpvotedProblem = provider.allProblems.isEmpty
            ? null
            : provider.allProblems.first;

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(41),
              topRight: Radius.circular(41),
            ),
          ),
          child: Column(
            children: [
              // 1. Most Upvoted Area Card
              _buildMostUpvotedCard(mostUpvotedProblem),

              // 2. Statistics Row
              _buildStatRow(stats),

              const SizedBox(height: 16),

              // 3. Filters Section
              FiltersSection(
                selectedTag: provider.selectedTag,
                selectedCategory: provider.selectedCategory,
                onTagSelected: (tag) => provider.setFilters(tag: tag),
                onCategorySelected: (cat) => provider.setFilters(category: cat),
              ),

              // 4. Problems List
              Expanded(
                child: filteredList.isEmpty
                    ? const Center(
                        child: Text(
                          'ไม่พบข้อมูล',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        key: const PageStorageKey('problemsList'),
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final problem = filteredList[index];
                          return ProblemCard(
                            key: ValueKey(problem.id),
                            problem: problem,
                            onDeleted: () => provider.fetchProblems(),
                            onUpvote: (isUpvoted) => provider.toggleUpvote(
                              problemId: problem.id,
                              isUpvoted: isUpvoted,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Helper Widgets ---

  Widget _buildMostUpvotedCard(ProblemEntity? problem) {
    final location = problem?.locationName ?? 'ไม่มีข้อมูล';
    final upvotes = problem?.upvoteCount ?? 0;

    return GestureDetector(
      onTap: problem != null
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AreaProblemsMapPage(
                    areaName: location,
                    problems: [problem],
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF5D3891), Color(0xFF7E57C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'พื้นที่ที่ถูกอัปโหวตมากที่สุด',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (problem != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '1 รายการ • $upvotes upvotes • แตะเพื่อดูแผนที่',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.trending_up, color: Colors.white, size: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(Map<ProblemTag, int> stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              label: 'รอดำเนินการ',
              count: (stats[ProblemTag.pending] ?? 0) + (stats[ProblemTag.received] ?? 0),
              color: const Color(0xFFE53935),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              label: 'ดำเนินการอยู่',
              count: stats[ProblemTag.inProgress] ?? 0,
              color: const Color(0xFFFF8604),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              label: 'เสร็จสิ้น',
              count: stats[ProblemTag.completed] ?? 0,
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
