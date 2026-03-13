/*
 * File: problem_image_repo.dart
 * Description: Abstract repository interface for problem image data operations.
 * Responsibilities: Declares the contract for fetching, storing, and modifying images associated with problems.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/entities/problem_image_entity.dart';

/// The contract for interacting with image data directly linked to reported problems.
abstract class ProblemImageRepo {
  /// Retrieves a list of images tied to a specific [problemId].
  ///
  /// This operates asynchronously and fetches metadata from the remote service.
  Future<List<ProblemImageEntity>> getProblemImageByProblemId(String problemId);

  /// Creates and links a new image to the specified [problemId].
  ///
  /// The [imageUrl], [fileName], and [imageType] parameters specify the core details.
  /// Returns the newly generated image identifier.
  Future<String> createProblemImage({
      required String problemId,
      required String imageUrl,
      required String fileName,
      required String imageType,
  });

  /// Updates attributes of an existing image specified by [problemImageId] and [problemId].
  ///
  /// Supply optionally the new [imageUrl], [fileName], or [imageType] to replace existing ones.
  Future<void> updateProblemImage({
    required String problemImageId,
    required String problemId,
    String? imageUrl,
    String? fileName,
    String? imageType,
  });

  /// Deletes a specific image from the system using [problemImageId].
  ///
  /// Side effects:
  /// Permanently removes the image record. Throws an exception if removal fails.
  Future<void> deleteProblemImage(String problemImageId);
}
