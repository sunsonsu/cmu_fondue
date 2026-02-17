// Komsan
class ProblemTagEntity {
  final String problemTagId;
  final String tagName;
  final String tagThaiName;

  ProblemTagEntity({
    required this.problemTagId,
    required this.tagName,
    required this.tagThaiName,
  });

  factory ProblemTagEntity.fromGenerated(dynamic sdkData) {
    return ProblemTagEntity(
      problemTagId: sdkData.problemTagId,
      tagName: sdkData.tagName,
      tagThaiName: sdkData.tagThaiName,
    );
  }

}