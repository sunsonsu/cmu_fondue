// Komsan
class ProblemTypeEntity {
  final String problemTypeId;
  final String typeName;
  final String typeThaiName;

  ProblemTypeEntity({
    required this.problemTypeId,
    required this.typeName,
    required this.typeThaiName,
  });

  factory ProblemTypeEntity.fromGenerated(dynamic sdkData) {
    return ProblemTypeEntity(
      problemTypeId: sdkData.problemTypeId,
      typeName: sdkData.typeName,
      typeThaiName: sdkData.typeThaiName,
    );
  }

}