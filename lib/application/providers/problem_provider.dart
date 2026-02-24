import 'dart:io';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_upvote_usecase.dart';
import 'package:flutter/material.dart';

class ProblemProvider with ChangeNotifier {
  Future<ProblemEntity?> getMaxUpvotedProblem() async {
    try {
      return await _getProblemsUseCase.getMaxUpvotedProblem();
    } catch (e, stacktrace) {
      print('Get Max Upvoted Problem Error: $e');
      print('Stacktrace: $stacktrace');
      return null;
    }
  }

  Future<int> countProblemsByTag({required String currentTagId}) async {
    try {
      return await _getProblemsUseCase.countByTag(currentTagId);
    } catch (e, stacktrace) {
      print('Count by Tag Error: $e');
      print('Stacktrace: $stacktrace');
      return 0;
    }
  }

  final GetProblemsUseCase _getProblemsUseCase;
  final CreateProblemUseCase _createProblemUseCase;
  final UpdateProblemUpvoteUseCase _updateProblemUpvoteUseCase;

  ProblemProvider(
    this._getProblemsUseCase,
    this._createProblemUseCase,
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
      _problems = await _getProblemsUseCase();
    } catch (e, stacktrace) {
      print('Fetch Error: $e');
      print('Stacktrace: $stacktrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNotCompletedProblems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _problems = await _getProblemsUseCase.getNotCompletedProblems();
    } catch (e, stacktrace) {
      print('Fetch Error: $e');
      print('Stacktrace: $stacktrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<ProblemEntity>> fetchProblemsByTagAndType({
    required String tagId,
    required String typeId,
  }) async {
    try {
      return await _getProblemsUseCase.getProblemsByTagAndType(
        tagId: tagId,
        typeId: typeId,
      );
    } catch (e, stacktrace) {
      print('Fetch by Tag and Type Error: $e');
      print('Stacktrace: $stacktrace');
      return [];
    }
  }

  Future<List<ProblemEntity>> fetchProblemsByTag({
    required String tagId,
  }) async {
    try {
      return await _getProblemsUseCase.getProblemsByTag(tagId: tagId);
    } catch (e, stacktrace) {
      print('Fetch by Tag Error: $e');
      print('Stacktrace: $stacktrace');
      return [];
    }
  }

  Future<List<ProblemEntity>> fetchProblemsByType({
    required String typeId,
  }) async {
    try {
      return await _getProblemsUseCase.getProblemsByType(typeId: typeId);
    } catch (e, stacktrace) {
      print('Fetch by Type Error: $e');
      print('Stacktrace: $stacktrace');
      return [];
    }
  }

  Future<void> createProblem({
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
    required File imageFile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _createProblemUseCase(
        title: title,
        detail: detail,
        locationName: locationName,
        lat: lat,
        lng: lng,
        reporterId: reporterId,
        typeId: typeId,
        tagId: tagId,
        imageFile: imageFile,
      );
      await fetchProblems(); // รีเฟรชข้อมูลหน้ารายการใหม่หลังจากสร้างสำเร็จ
    } catch (e, stacktrace) {
      print('Create Error: $e');
      print('Stacktrace: $stacktrace');
      rethrow; // ส่ง Error กลับไปให้ UI แสดงแจ้งเตือน
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
      // สำคัญ: อัปเดตข้อมูลใน List ของ Provider ด้วย!
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
        notifyListeners(); // แจ้งทุกหน้าจอที่ฟังอยู่ให้วาดใหม่
      }
    } catch (e, stacktrace) {
      print('Toggle Upvote Error: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }
}
