/*
 * File: problem_tag_entity.dart
 * Description: Entity representing a tag or status category for a problem.
 * Responsibilities: Holds the tag data and provides a factory for parsing from generated SDK data.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 */

/// Represents a tag used to classify the status of a problem.
class ProblemTagEntity {
  /// The unique identifier of the problem tag.
  final String problemTagId;

  /// The internal or English name of the tag.
  final String tagName;

  /// The Thai translation of the tag name for display purposes.
  final String tagThaiName;

  /// Initializes a new instance of [ProblemTagEntity].
  ProblemTagEntity({
    required this.problemTagId,
    required this.tagName,
    required this.tagThaiName,
  });

  /// Constructs an entity from dynamic generated SDK data.
  factory ProblemTagEntity.fromGenerated(dynamic sdkData) {
    return ProblemTagEntity(
      problemTagId: sdkData.problemTagId,
      tagName: sdkData.tagName,
      tagThaiName: sdkData.tagThaiName,
    );
  }
}