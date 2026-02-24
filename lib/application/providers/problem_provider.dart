import 'dart:io';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_upvote_usecase.dart';
import 'package:flutter/material.dart';

class ProblemProvider with ChangeNotifier {
  final GetProblemsUseCase _getProblemsUseCase;
  final CreateProblemUseCase _createProblemUseCase;
  final UpdateProblemUpvoteUseCase _updateProblemUpvoteUseCase;

  String? _currentUserId;
  bool _isLoading = false;
  List<ProblemEntity> _problems = [];

  ProblemTag? _selectedTag;
  ProblemType? _selectedCategory;

  ProblemProvider(
    this._getProblemsUseCase,
    this._createProblemUseCase,
    this._updateProblemUpvoteUseCase,
  );

  bool get isLoading => _isLoading;

  ProblemTag? get selectedTag => _selectedTag;
  ProblemType? get selectedCategory => _selectedCategory;

  List<ProblemEntity> get allProblems => _problems;
  List<ProblemEntity> get notCompletedProblems =>
      _problems.where((p) => p.tagName != ProblemTag.completed).toList();

  List<ProblemEntity> get filteredProblems {
    return _problems.where((p) {
      final matchTag = _selectedTag == null || p.tagName == _selectedTag;
      final matchType =
          _selectedCategory == null || p.typeName == _selectedCategory;
      return matchTag && matchType;
    }).toList();
  }

  int get countPending =>
      _problems.where((p) => p.tagName == ProblemTag.pending).length;
  int get countInProgress =>
      _problems.where((p) => p.tagName == ProblemTag.inProgress).length;
  int get countCompleted =>
      _problems.where((p) => p.tagName == ProblemTag.completed).length;

  Map<String, dynamic> getMostReportedAreaData() {
    // 1. ถ้าไม่มีข้อมูลในระบบเลย ให้ส่งค่า Default กลับไป
    if (_problems.isEmpty) {
      return {
        'location': 'ไม่มีข้อมูล',
        'problems': <ProblemEntity>[],
        'upvotes': 0,
      };
    }

    // 2. จัดกลุ่มปัญหาตามชื่อสถานที่ (locationName)
    // Key: ชื่อสถานที่, Value: List ของปัญหาที่เกิด ณ ที่นั้น
    Map<String, List<ProblemEntity>> locationGroups = {};
    for (var problem in _problems) {
      if (!locationGroups.containsKey(problem.locationName)) {
        locationGroups[problem.locationName] = [];
      }
      locationGroups[problem.locationName]!.add(problem);
    }

    // 3. หาพื้นที่ที่มีผลกระทบสูงสุด (วัดจากผลรวมของ Upvote ทั้งหมดในพื้นที่นั้น)
    String mostReportedLocation = '';
    List<ProblemEntity> mostReportedProblems = [];
    int maxUpvoteSum = -1; // เริ่มต้นที่ -1 เพื่อให้เจอค่าที่มากกว่าเสมอ

    locationGroups.forEach((location, problemsInArea) {
      // คำนวณผลรวม Upvote ของปัญหาย่อยๆ ทั้งหมดในสถานที่นี้
      int totalUpvotes = problemsInArea.fold(
        0,
        (sum, problem) => sum + problem.upvoteCount,
      );

      // ถ้าคะแนนรวม Upvote ของที่นี่ มากกว่าที่เคยบันทึกไว้ ให้เปลี่ยนเป็นที่นี่แทน
      if (totalUpvotes > maxUpvoteSum) {
        maxUpvoteSum = totalUpvotes;
        mostReportedLocation = location;
        mostReportedProblems = problemsInArea;
      }
    });

    // 4. ส่งข้อมูลสรุปกลับไปให้ Dashboard ใช้งาน
    return {
      'location': mostReportedLocation,
      'problems': mostReportedProblems,
      'upvotes': maxUpvoteSum,
    };
  }

  Map<String, int> getStatistics() {
    return {
      'pending': _problems.where((p) => p.tagName == ProblemTag.pending).length,
      'inProgress': _problems
          .where((p) => p.tagName == ProblemTag.inProgress)
          .length,
      'completed': _problems
          .where((p) => p.tagName == ProblemTag.completed)
          .length,
    };
  }

  void setFilters({ProblemTag? tag, ProblemType? category}) {
    _selectedTag = tag;
    _selectedCategory = category;
    notifyListeners(); // แจ้ง Consumer ให้วาดใหม่พร้อมข้อมูลที่กรองแล้ว
  }

  void updateUserId(String? userId) {
    if (_currentUserId == userId) return;
    _currentUserId = userId;
    debugPrint('ProblemProvider updated with userId: $_currentUserId');
    notifyListeners();
  }

  Future<void> fetchProblems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _problems = await _getProblemsUseCase(_currentUserId);
    } catch (e) {
      debugPrint('Fetch Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleUpvote({
    required String problemId,
    required bool isUpvoted,
  }) async {
    await _updateProblemUpvoteUseCase(
      problemId: problemId,
      isUpvoted: isUpvoted,
      userId: _currentUserId,
    );
    final index = _problems.indexWhere((p) => p.id == problemId);
    if (index != -1) {
      _problems[index] = _problems[index].copyWith(
        upvoteCount: isUpvoted
            ? _problems[index].upvoteCount + 1
            : _problems[index].upvoteCount - 1,
        isUpvotedByMe: isUpvoted,
      );
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

  Future<ProblemEntity?> getMaxUpvotedProblem() async {
    try {
      return await _getProblemsUseCase.getMaxUpvotedProblem(_currentUserId);
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
}
