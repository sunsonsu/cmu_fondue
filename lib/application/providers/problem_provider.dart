import 'dart:io';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/delete_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_upvote_usecase.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';

class ProblemWithDistance {
  final ProblemEntity problem;
  final double distance;

  ProblemWithDistance(this.problem, this.distance);
}

class ProblemProvider with ChangeNotifier {
  final GetProblemsUseCase _getProblemsUseCase;
  final CreateProblemUseCase _createProblemUseCase;
  final UpdateProblemUpvoteUseCase _updateProblemUpvoteUseCase;
  final DeleteProblemUseCase _deleteProblemUseCase;

  ProblemProvider(
    this._getProblemsUseCase,
    this._createProblemUseCase,
    this._updateProblemUpvoteUseCase,
    this._deleteProblemUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProblemEntity> _problems = [];
  List<ProblemEntity> get problems => _problems;

  List<ProblemEntity> get notCompletedProblems =>
      _problems.where((p) => p.tagName != ProblemTag.completed).toList();

  List<ProblemEntity> getNearbyProblems(
    double lat,
    double lng, {
    double maxDistance = 500,
    bool onlyNotCompleted = false,
  }) {
    final List<ProblemWithDistance> problemsWithDistance = [];
    final sourceList = onlyNotCompleted ? notCompletedProblems : _problems;
    for (var p in sourceList) {
      double distance = Geolocator.distanceBetween(lat, lng, p.lat, p.lng);
      if (distance <= maxDistance) {
        problemsWithDistance.add(ProblemWithDistance(p, distance));
      }
    }
    problemsWithDistance.sort((a, b) => a.distance.compareTo(b.distance));
    return problemsWithDistance.map((e) => e.problem).toList();
  }

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

  Future<void> deleteProblem({required String problemId}) async {
    try {
      await _deleteProblemUseCase(problemId);

      _problems.removeWhere((p) => p.id == problemId);
      notifyListeners();
    } catch (e, stacktrace) {
      print('Delete Error: $e');
      print('Stacktrace: $stacktrace');
      rethrow; // ส่ง Error กลับไปให้ UI แสดงแจ้งเตือน
    }
  }
}
