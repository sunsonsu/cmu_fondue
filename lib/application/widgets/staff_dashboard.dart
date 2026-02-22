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

  Map<String, int> _getStatistics() {
    int pending = _allProblems
        .where((p) => p.tagName == ProblemTag.pending)
        .length;
    int inProgress = _allProblems
        .where((p) => p.tagName == ProblemTag.inProgress)
        .length;
    int completed = _allProblems
        .where((p) => p.tagName == ProblemTag.completed)
        .length;

    return {
      'pending': pending,
      'inProgress': inProgress,
      'completed': completed,
    };
  }

  Map<String, dynamic> _getMostReportedAreaData() {
    if (_allProblems.isEmpty) {
      return {
        'location': 'ไม่มีข้อมูล',
        'problems': <ProblemEntity>[],
        'upvotes': 0,
      };
    }

    // Group problems by location
    Map<String, List<ProblemEntity>> locationProblems = {};
    for (var problem in _allProblems) {
      if (!locationProblems.containsKey(problem.locationName)) {
        locationProblems[problem.locationName] = [];
      }
      locationProblems[problem.locationName]!.add(problem);
    }

    // Find location with max total upvotes
    String mostReported = '';
    List<ProblemEntity> mostReportedProblems = [];
    int maxUpvoteCount = 0;
    locationProblems.forEach((location, problems) {
      // Calculate total upvotes for this location
      int totalUpvotes = problems.fold(
        0,
        (sum, problem) => sum + problem.upvoteCount,
      );
      if (totalUpvotes > maxUpvoteCount) {
        maxUpvoteCount = totalUpvotes;
        mostReported = location;
        mostReportedProblems = problems;
      }
    });

    return {
      'location': mostReported,
      'problems': mostReportedProblems,
      'upvotes': maxUpvoteCount,
    };
  }

  @override
  Widget build(BuildContext context) {
    final stats = _getStatistics();
    final mostReportedData = _getMostReportedAreaData();
    final mostReportedLocation = mostReportedData['location'] as String;
    final mostReportedProblems =
        mostReportedData['problems'] as List<ProblemEntity>;
    final mostReportedUpvotes = mostReportedData['upvotes'] as int;

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
                GestureDetector(
                  onTap: mostReportedProblems.isNotEmpty
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AreaProblemsMapPage(
                                areaName: mostReportedLocation,
                                problems: mostReportedProblems,
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
                                'พื้นที่ที่ส่งผลกระทบมากที่สุด',
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
                                      mostReportedLocation,
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
                              if (mostReportedProblems.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  '${mostReportedProblems.length} รายการ • ${mostReportedUpvotes} upvotes • แตะเพื่อดูแผนที่',
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
