/*
 * File: problem_type_entity.dart
 * Description: Entity representing a category type of a problem.
 * Responsibilities: Holds the problem type data and provides a factory for parsing from generated SDK data.
 * Author: Komsan
 * Course: CMU Fondue
 */

/// Represents a type category that a problem falls under.
class ProblemTypeEntity {
  /// The unique identifier of the problem type.
  final String problemTypeId;

  /// The internal or English name of the problem type.
  final String typeName;

  /// The Thai translation of the problem type for display purposes.
  final String typeThaiName;

  /// Initializes a new instance of [ProblemTypeEntity].
  ProblemTypeEntity({
    required this.problemTypeId,
    required this.typeName,
    required this.typeThaiName,
  });

  /// Constructs an entity from dynamic generated SDK data.
  factory ProblemTypeEntity.fromGenerated(dynamic sdkData) {
    return ProblemTypeEntity(
      problemTypeId: sdkData.problemTypeId,
      typeName: sdkData.typeName,
      typeThaiName: sdkData.typeThaiName,
    );
  }
}