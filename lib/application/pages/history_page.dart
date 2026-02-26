import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:cmu_fondue/domain/usecases/get_user_problems_usecase.dart';
import 'package:cmu_fondue/data/repositories/problem_repo_impl.dart';
import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final GetUserProblemsUseCase _getUserProblemsUseCase;
  List<ProblemEntity> _userProblems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize the use case with repository
    final connector = ConnectorConnector.instance;
    final problemRepo = ProblemRepoImpl(connector: connector);
    _getUserProblemsUseCase = GetUserProblemsUseCase(problemRepo);
    _loadProblems();
  }

  Future<void> _loadProblems() async {
    setState(() => _isLoading = true);

    try {
      final authProvider = context.read<AppAuthProvider>();
      final userId = authProvider.user?.id;

      if (userId != null) {
        final problems = await _getUserProblemsUseCase(
          reporterId: userId,
          currentUserId: userId,
        );

        setState(() {
          _userProblems = problems;
          _isLoading = false;
        });
      } else {
        setState(() {
          _userProblems = [];
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading user problems: $e');
      setState(() {
        _userProblems = [];
        _isLoading = false;
      });
    }
  }

  List<ProblemEntity> _filterByStatus(List<ProblemTag> tags) {
    return _userProblems.where((p) => tags.contains(p.tagName)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pendingProblems = _filterByStatus([
      ProblemTag.pending,
      ProblemTag.received,
    ]);
    final inProgressProblems = _filterByStatus([ProblemTag.inProgress]);
    final completedProblems = _filterByStatus([ProblemTag.completed]);

    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ประวัติการแจ้งเรื่อง',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _loadProblems,
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
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  children: [
                    // รอเคลม Section
                    if (pendingProblems.isNotEmpty) ...[
                      _buildSectionHeader(
                        'รอดำเนินการ',
                        pendingProblems.length,
                      ),
                      ...pendingProblems.map(
                        (p) =>
                            ProblemCard(problem: p, onDeleted: _loadProblems),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // กำลังเคลม Section
                    if (inProgressProblems.isNotEmpty) ...[
                      _buildSectionHeader(
                        'กำลังดำเนินการ',
                        inProgressProblems.length,
                      ),
                      ...inProgressProblems.map(
                        (p) =>
                            ProblemCard(problem: p, onDeleted: _loadProblems),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // เสร็จสิ้น Section
                    if (completedProblems.isNotEmpty) ...[
                      _buildSectionHeader(
                        'เสร็จสิ้น',
                        completedProblems.length,
                      ),
                      ...completedProblems.map(
                        (p) =>
                            ProblemCard(problem: p, onDeleted: _loadProblems),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        '$title ($count)',
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }
}
