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
  List<ProblemEntity> _allProblems = [];
  List<ProblemEntity> _filteredProblems = [];
  bool _isLoading = true;

  Map<String, int> _statistics = {
    'pending': 0,
    'inProgress': 0,
    'completed': 0,
  };

  ProblemTag? _selectedTag;
  ProblemType? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadProblems();
  }

  Future<void> _loadProblems() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ProblemProvider>(context, listen: false);
      await provider.fetchProblems();
      setState(() {
        _allProblems = provider.problems;
        _filteredProblems = provider.problems;
        _isLoading = false;
      });
      await _loadStatistics();
    });
  }

  Future<void> _loadStatistics() async {
    final provider = Provider.of<ProblemProvider>(context, listen: false);
    final pending = await provider.countProblemsByTag(
      currentTagId: ProblemTag.pending.tagId,
    );
    final inProgress = await provider.countProblemsByTag(
      currentTagId: ProblemTag.inProgress.tagId,
    );
    final completed = await provider.countProblemsByTag(
      currentTagId: ProblemTag.completed.tagId,
    );
    setState(() {
      _statistics = {
        'pending': pending,
        'inProgress': inProgress,
        'completed': completed,
      };
    });
  }

  Future<void> _applyFilters() async {
    final provider = Provider.of<ProblemProvider>(context, listen: false);
    List<ProblemEntity> results;

    if (_selectedTag != null && _selectedCategory != null) {
      // Both filters — query by tag and type
      results = await provider.fetchProblemsByTagAndType(
        tagId: _selectedTag!.tagId,
        typeId: _selectedCategory!.typeId,
      );
    } else if (_selectedTag != null) {
      // Tag only
      results = await provider.fetchProblemsByTag(tagId: _selectedTag!.tagId);
    } else if (_selectedCategory != null) {
      // Type only
      results = await provider.fetchProblemsByType(
        typeId: _selectedCategory!.typeId,
      );
    } else {
      // No filters — show all
      results = _allProblems;
    }

    setState(() {
      _filteredProblems = results;
    });
  }

  Future<Map<String, dynamic>> _getMostUpvotedAreaData() async {
    final provider = Provider.of<ProblemProvider>(context, listen: false);
    try {
      final problem = await provider.getMaxUpvotedProblem();
      print(problem);
      if (problem == null) {
        return {'location': 'ไม่มีข้อมูล', 'problem': null, 'upvotes': 0};
      }
      return {
        'location': problem.locationName,
        'problem': problem,
        'upvotes': problem.upvoteCount,
      };
    } catch (e) {
      return {'location': 'ไม่มีข้อมูล', 'problem': null, 'upvotes': 0};
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = _statistics;
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(41),
                topRight: Radius.circular(41),
              ),
            ),
            child: Column(
              children: [
                // Most Upvoted Area Section
                FutureBuilder<Map<String, dynamic>>(
                  future: _getMostUpvotedAreaData(),
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    final location = data != null
                        ? data['location'] as String
                        : 'ไม่มีข้อมูล';
                    final problem = data != null
                        ? data['problem'] as ProblemEntity?
                        : null;
                    final upvotes = data != null ? data['upvotes'] as int : 0;
                    return GestureDetector(
                      onTap: problem != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AreaProblemsMapPage(
                                    areaName: location,
                                    problems: problem != null ? [problem] : [],
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
                            const Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Statistics Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          label: 'รอดำเนินการ',
                          count: stats['pending']!,
                          color: const Color(0xFFE53935),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          label: 'ดำเนินการอยู่',
                          count: stats['inProgress']!,
                          color: const Color(0xFFFF8604),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          label: 'เสร็จสิ้น',
                          count: stats['completed']!,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Filters Section
                FiltersSection(
                  selectedTag: _selectedTag,
                  selectedCategory: _selectedCategory,
                  onTagSelected: (tag) {
                    setState(() {
                      _selectedTag = tag;
                    });
                    _applyFilters();
                  },
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                    _applyFilters();
                  },
                ),

                // Problems List
                Expanded(
                  child: _filteredProblems.isEmpty
                      ? const Center(
                          child: Text(
                            'ไม่พบข้อมูล',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredProblems.length,
                          itemBuilder: (context, index) {
                            return ProblemCard(
                              problem: _filteredProblems[index],
                              onDeleted: () {
                                // Refresh after delete
                                _loadProblems();
                              },
                            );
                          },
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
