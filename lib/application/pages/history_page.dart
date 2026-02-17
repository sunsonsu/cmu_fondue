import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:cmu_fondue/domain/usecases/get_problems_nearby.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GetProblemsNearbyUseCase _getProblemsUseCase = GetProblemsNearbyUseCase();
  List<ProblemEntity> _userProblems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProblems();
  }

  Future<void> _loadProblems() async {
    setState(() => _isLoading = true);
    
    // ดึงข้อมูลจาก GetProblemsNearbyUseCase
    final problems = await _getProblemsUseCase();
    
    setState(() {
      _userProblems = problems;
      _isLoading = false;
    });
  }

  List<ProblemEntity> _filterByStatus(List<ProblemTag> tags) {
    return _userProblems.where((p) => tags.contains(p.tagName)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pendingProblems = _filterByStatus([ProblemTag.pending, ProblemTag.received]);
    final inProgressProblems = _filterByStatus([ProblemTag.inProgress]);
    final completedProblems = _filterByStatus([ProblemTag.completed]);

    return RefreshIndicator(
      onRefresh: _loadProblems,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ประวัติการแจ้งเรื่อง',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _userProblems.isEmpty
                    ? const Center(
                        child: Text(
                          'ไม่มีประวัติการแจ้งเรื่อง',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          // รอเคลม Section
                          if (pendingProblems.isNotEmpty) ...[
                            _buildSectionHeader('รอดำเนินการ', pendingProblems.length),
                            ...pendingProblems.map((p) => ProblemCard(
                                  problem: p,
                                  onDeleted: _loadProblems,
                                )),
                            const SizedBox(height: 16),
                          ],

                          // กำลังเคลม Section
                          if (inProgressProblems.isNotEmpty) ...[
                            _buildSectionHeader('กำลังดำเนินการ', inProgressProblems.length),
                            ...inProgressProblems.map((p) => ProblemCard(
                                  problem: p,
                                  onDeleted: _loadProblems,
                                )),
                            const SizedBox(height: 16),
                          ],

                          // เสร็จสิ้น Section
                          if (completedProblems.isNotEmpty) ...[
                            _buildSectionHeader('เสร็จสิ้น', completedProblems.length),
                            ...completedProblems.map((p) => ProblemCard(
                                  problem: p,
                                  onDeleted: _loadProblems,
                                )),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        '$title ($count)',
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
