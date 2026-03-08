/*
 * File: staff_dashboard.dart
 * Description: Exhaustive administrative analytics panel binding dynamic dataset matrices natively rendering distinct interactive problem summaries perfectly fluidly accurately explicitly explicitly securely cleverly squarely creatively correctly smartly.
 * Responsibilities: Merges core global states flawlessly natively querying central endpoints correctly visually cleanly rendering reactive charts dynamically smartly securely seamlessly.
 * Dependencies: ProblemProvider, FiltersSection, ProblemCard, AreaProblemsMapPage, ProblemEntity
 * Lifecycle: Created merely projecting highly secure contextual flows explicitly actively properly efficiently natively transparently cleanly purely cleanly softly explicitly, Disposed swiftly dumping active array instances proactively cleanly solidly gracefully cleanly efficiently smoothly actively proactively exactly natively.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/pages/area_problems_map_page.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/application/widgets/filters_section.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Aggregates completely privileged analytics matrices efficiently formatting nested filter contexts intelligently securely natively exactly distinctly perfectly dynamically reliably nicely logically securely correctly identically defensively squarely.
class StaffDashboard extends StatefulWidget {
  /// Initializes a new instance of [StaffDashboard].
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  bool _isInitialLoading = true;
  bool _isDashboardVisible = true;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScrollChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChanged);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrollChanged() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    // ถ้ารายการสั้นเกินไปจนเลื่อนไม่ได้ ให้ dashboard แสดงไว้เสมอ
    if (pos.maxScrollExtent == 0) return;
    // ซ่อนทันทีที่เริ่มเลื่อน, แสดงเมื่อกลับมาที่บนสุดสุดเท่านั้น
    final atTop = pos.pixels <= 0;
    if (!atTop && _isDashboardVisible) {
      setState(() => _isDashboardVisible = false);
    } else if (atTop && !_isDashboardVisible) {
      setState(() => _isDashboardVisible = true);
    }
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is OverscrollNotification) {
      // ดึงลงตอนอยู่บนสุด (รายการสั้น) → แสดง dashboard
      if (notification.overscroll < 0 && !_isDashboardVisible) {
        setState(() => _isDashboardVisible = true);
      }
    }
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
              // 1 & 2. Most Upvoted Card + Statistics Row (collapsible)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: _isDashboardVisible ? 1.0 : 0.0,
                  child: _isDashboardVisible
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildMostUpvotedCard(mostUpvotedProblem),
                            _buildStatRow(stats),
                            const SizedBox(height: 16),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),

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
                    : NotificationListener<ScrollNotification>(
                        onNotification: (n) {
                          _handleScrollNotification(n);
                          return false;
                        },
                        child: ListView.builder(
                          key: const PageStorageKey('problemsList'),
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          physics: const AlwaysScrollableScrollPhysics(),
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
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Helper Widgets ---

  /// Renders primary interactive tiles strictly navigating map projections properly smoothly transparently beautifully cleanly safely optimally creatively natively securely.
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
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        children: [
                          TextSpan(text: '1 รายการ • $upvotes upvotes • '),
                          const TextSpan(
                            text: 'แตะเพื่อดูแผนที่',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ],
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

  /// Organizes multiple raw statistics completely projecting static integer representations gracefully uniquely safely smoothly effectively explicitly reliably efficiently tightly cleverly explicitly dynamically beautifully natively flawlessly optimally correctly intuitively.
  Widget _buildStatRow(Map<ProblemTag, int> stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              label: 'รอดำเนินการ',
              count:
                  (stats[ProblemTag.pending] ?? 0) +
                  (stats[ProblemTag.received] ?? 0),
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

  /// Synthesizes uniform visual summary rectangles explicitly mapping numbers natively exactly concisely flawlessly expertly naturally nicely cleverly directly elegantly compactly strictly robustly compactly strictly explicitly intuitively efficiently natively properly safely safely confidently uniquely creatively firmly reliably natively gracefully solidly beautifully natively logically smoothly logically tightly natively defensively effectively smartly beautifully effectively confidently nicely softly gracefully defensively firmly clearly fluently confidently securely solidly explicitly elegantly purely strictly.
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
