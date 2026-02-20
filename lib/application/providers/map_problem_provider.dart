import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_upvote_usecase.dart';
import 'package:flutter/material.dart';

/// Provider เฉพาะหน้าแผนที่ — ดึงเฉพาะปัญหาที่ยังไม่เสร็จสิ้น
class MapProblemProvider with ChangeNotifier {
  final GetProblemsUseCase _getProblemsUseCase;
  final UpdateProblemUpvoteUseCase _updateProblemUpvoteUseCase;

  MapProblemProvider(
    this._getProblemsUseCase,
    this._updateProblemUpvoteUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProblemEntity> _problems = [];
  List<ProblemEntity> get problems => _problems;

  Future<void> fetchProblems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _problems = await _getProblemsUseCase.getNotCompletedProblems();
    } catch (e, stacktrace) {
      print('MapProblemProvider Fetch Error: $e');
      print('Stacktrace: $stacktrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleUpvote({
    required String problemId,
    required bool isUpvoted,
  }) async {
    try {
      await _updateProblemUpvoteUseCase(
        problemId: problemId,
        isUpvoted: isUpvoted,
      );
      final index = _problems.indexWhere((p) => p.id == problemId);
      if (index != -1) {
        final oldProblem = _problems[index];
        _problems[index] = ProblemEntity(
          id: oldProblem.id,
          title: oldProblem.title,
          detail: oldProblem.detail,
          lat: oldProblem.lat,
          lng: oldProblem.lng,
          upvoteCount: isUpvoted
              ? oldProblem.upvoteCount + 1
              : oldProblem.upvoteCount - 1,
          createdAt: oldProblem.createdAt,
          reporterEmail: oldProblem.reporterEmail,
          typeName: oldProblem.typeName,
          tagName: oldProblem.tagName,
          locationName: oldProblem.locationName,
          isUpvotedByMe: isUpvoted,
          imageUrl: oldProblem.imageUrl,
        );
        notifyListeners();
      }
    } catch (e, stacktrace) {
      print('MapProblemProvider Toggle Upvote Error: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }
}
