import 'dart:io';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:flutter/material.dart';

class ProblemProvider with ChangeNotifier {
  final GetProblemsUseCase _getProblemsUseCase;
  final CreateProblemUseCase _createProblemUseCase;

  ProblemProvider(this._getProblemsUseCase, this._createProblemUseCase);

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
    } catch (e) {
      rethrow; // ส่ง Error กลับไปให้ UI แสดงแจ้งเตือน
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
