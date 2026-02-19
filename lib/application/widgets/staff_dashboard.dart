import 'package:cmu_fondue/application/widgets/filters_section.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:cmu_fondue/domain/usecases/get_problems_nearby.dart';
import 'package:flutter/material.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  final GetProblemsNearbyUseCase _getProblemsUseCase = GetProblemsNearbyUseCase();
  List<ProblemEntity> _allProblems = [];
  List<ProblemEntity> _filteredProblems = [];
  bool _isLoading = true;
  
  ProblemTag? _selectedTag;
  ProblemType? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadProblems();
  }

  Future<void> _loadProblems() async {
    setState(() => _isLoading = true);
    
    try {
      final problems = await _getProblemsUseCase();
      setState(() {
        _allProblems = problems;
        _filteredProblems = problems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredProblems = _allProblems.where((problem) {
        bool matchesTag = _selectedTag == null || problem.tagName == _selectedTag;
        bool matchesCategory = _selectedCategory == null || problem.typeName == _selectedCategory;
        return matchesTag && matchesCategory;
      }).toList();
    });
  }

  Map<String, int> _getStatistics() {
    int pending = _allProblems.where((p) => p.tagName == ProblemTag.pending).length;
    int inProgress = _allProblems.where((p) => p.tagName == ProblemTag.inProgress).length;
    int completed = _allProblems.where((p) => p.tagName == ProblemTag.completed).length;
    
    return {
      'pending': pending,
      'inProgress': inProgress,
      'completed': completed,
    };
  }

  String _getMostReportedArea() {
    if (_allProblems.isEmpty) return 'ไม่มีข้อมูล';
    
    // Count problems by location
    Map<String, int> locationCounts = {};
    for (var problem in _allProblems) {
      locationCounts[problem.locationName] = (locationCounts[problem.locationName] ?? 0) + 1;
    }
    
    // Find location with max count
    String mostReported = '';
    int maxCount = 0;
    locationCounts.forEach((location, count) {
      if (count > maxCount) {
        maxCount = count;
        mostReported = location;
      }
    });
    
    return mostReported;
  }

  @override
  Widget build(BuildContext context) {
    final stats = _getStatistics();
    
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
                  // Most Report Area Section
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5D3891), Color(0xFF7E57C2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Most Report Area',
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
                                    _getMostReportedArea(),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
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
