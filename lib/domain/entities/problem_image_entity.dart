/*
 * File: problem_image_entity.dart
 * Description: Entity representing an image associated with a reported problem.
 * Responsibilities: Holds the image URL, type, and metadata, and provides a factory for parsing from generated SDK data.
 * Author: Komsan
 * Course: CMU Fondue
 */

/// Represents a single image associated with a specific problem.
class ProblemImageEntity {
  /// The unique identifier for this problem image.
  final String problemImageId;

  /// The unique identifier of the problem this image belongs to.
  final String problemId;

  /// The absolute URL to the image resource.
  final String imageUrl;

  /// The display file name of the image.
  final String fileName;

  /// The MIME type or generic type identifier for the image.
  final String imageType;

  /// The date and time when the image was uploaded.
  final DateTime createdAt;

  /// Initializes a new instance of [ProblemImageEntity].
  ProblemImageEntity({
    required this.problemImageId,
    required this.problemId,
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
    required this.createdAt,
  });

  /// Constructs an entity from dynamic generated SDK data.
  factory ProblemImageEntity.fromGenerated(dynamic sdkData) {
    return ProblemImageEntity(
      problemImageId: sdkData.problemImageId,
      problemId: sdkData.problemId,
      imageUrl: sdkData.imageUrl,
      fileName: sdkData.fileName,
      imageType: sdkData.imageType,
      createdAt: sdkData.createdAt.toDateTime(),
    );
  }
}
