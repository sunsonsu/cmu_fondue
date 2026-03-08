/*
 * File: create_problem_usecase.dart
 * Description: Use case for composing and persisting new problem reports.
 * Responsibilities: Coordinates image upload, problem record creation, and problem image record linking. Includes rollback mechanisms.
 * Author: Komsan
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'dart:io';
import 'package:path/path.dart' as path;
import '../repositories/problem_repo.dart';
import '../repositories/problem_image_repo.dart';
import '../../data/services/FirebaseStorageService.dart';

/// Orchestrates the process of submitting a new problem report, including media uploads.
class CreateProblemUseCase {
  /// The dependent repository for core problem data.
  final ProblemRepo problemRepository;

  /// The dependent repository for linking images to problem metadata.
  final ProblemImageRepo problemImageRepository;

  /// The dependent service handling physical file storage on Firebase.
  final FirebaseStorageService storageService;

  /// Initializes a new instance of [CreateProblemUseCase].
  CreateProblemUseCase({
    required this.problemRepository,
    required this.problemImageRepository,
    required this.storageService,
  });

  /// Executes the creation sequence for a new problem report.
  ///
  /// This operates asynchronously. It first uploads the provided [imageFile] to cloud storage. 
  /// Upon successful upload, it persists the problem metadata. Finally, it creates the image linkage.
  /// Throws an exception if any step fails, attempting to roll back previously succeeded steps.
  Future<String> call({
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
    String? imageUrl;
    String? problemId;

    try {
      imageUrl = await storageService.uploadProblemImage(imageFile);

      problemId = await problemRepository.createProblem(
        title: title,
        detail: detail,
        locationName: locationName,
        lat: lat,
        lng: lng,
        reporterId: reporterId,
        typeId: typeId,
        tagId: tagId,
      );

      final String fileName = path.basename(imageFile.path);
      final String imageType = path.extension(imageFile.path)
          .replaceFirst('.', '')
          .toLowerCase();
      
      await problemImageRepository.createProblemImage(
        problemId: problemId,
        imageUrl: imageUrl,
        fileName: fileName,
        imageType: imageType.isEmpty ? 'jpg' : imageType,
      );

      return problemId;
      
    } catch (e) {
      if (problemId != null) {
        try {
          await problemRepository.deleteProblem(problemId);
        } catch (deleteError) {
          // Ignored
        }
      }
      
      if (imageUrl != null) {
        try {
          await storageService.deleteProblemImage(imageUrl);
        } catch (deleteError) {
          // Ignored
        }
      }
      
      rethrow;
    }
  }
}