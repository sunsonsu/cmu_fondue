
// Komsan
class ProblemImageEntity {
  final String problemImageId;
  final String problemId;
  final String imageUrl;
  final String fileName;
  final String imageType;
  final DateTime createdAt;

  ProblemImageEntity({
    required this.problemImageId,
    required this.problemId,
    required this.imageUrl,
    required this.fileName,
    required this.imageType,
    required this.createdAt,
  });

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
