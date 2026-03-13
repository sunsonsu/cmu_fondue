/*
 * File: problem_image_repo_impl.dart
 * Description: Concrete implementation of the ProblemImageRepo.
 * Responsibilities: Performs CRUD operations for image metadata using Firebase Data Connect generated classes.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_image_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_image_repo.dart';

/// Implements domain specifications for managing image metadata linked to problems via Firebase Data Connect.
class ProblemImageRepoImpl implements ProblemImageRepo {
  /// The generated connector responsible for query execution.
  final ConnectorConnector connector;

  /// Initializes a new instance of [ProblemImageRepoImpl].
  ProblemImageRepoImpl({required this.connector});

  @override
  Future<List<ProblemImageEntity>> getProblemImageByProblemId(String problemId) async {
   final result = await connector.problemImageByProblemId(problemId: problemId).execute();
   return result.data.problemImages.map((e) => ProblemImageEntity.fromGenerated(e)).toList();
  }

  @override
  Future<String> createProblemImage({
    required String problemId,
    required String imageUrl,
    required String fileName,
    required String imageType,
  }) async {
    final result = await connector.createProblemImage(
      problemId: problemId,
      imageUrl: imageUrl,
      fileName: fileName,
      imageType: imageType,
    ).execute();
    return result.data.problemImage_insert.problemImageId;
  }

  @override
  Future<void> updateProblemImage({
    required String problemImageId,
    required String problemId,
    String? imageUrl,
    String? fileName,
    String? imageType,
  }) async {
    final builder = connector.updateProblemImage(
      problemImageId: problemImageId,
      problemId: problemId,
    );
    
    if (imageUrl != null) builder.imageUrl(imageUrl);
    if (fileName != null) builder.fileName(fileName);
    if (imageType != null) builder.imageType(imageType);
    
    await builder.execute();
  }

  @override
  Future<void> deleteProblemImage(String problemImageId) async {
    await connector.deleteProblemImage(problemImageId: problemImageId).execute();
  }
}