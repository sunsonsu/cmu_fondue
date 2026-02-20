import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

class ProblemRepoImpl implements ProblemRepo {
  final ConnectorConnector connector;
  ProblemRepoImpl({required this.connector});

  // Read
  // Komsan
  @override
  Future<List<ProblemEntity>> getProblems() async {
    try {
      // 1. เรียก Query จาก Data Connect SDK (ตัวอย่างชื่อ listProblems)
      final result = await connector.listProblems().execute();

      // 2. Map ข้อมูลจาก SDK Object ให้กลายเป็น Domain Entity
      // e ในที่นี้คือข้อมูลดิบที่มีความสัมพันธ์ (Nested Object) ติดมาด้วย
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาได้: $e");
    }
  }

  @override
  Future<List<ProblemEntity>> getNotCompletedProblems() async {
    try {
      final result = await connector.listNotCompletedProblems().execute();
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาที่ยังไม่เสร็จสิ้นได้: $e");
    }
  }

  // Create
  // Komsan
  @override
  Future<String> createProblem({
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
  }) async {
    final result = await connector
        .createProblem(
          title: title,
          detail: detail,
          locationName: locationName,
          lat: lat,
          lng: lng,
          reporterId: reporterId,
          typeId: typeId,
          tagId: tagId,
        )
        .execute();

    return result.data.problem_insert.problemId;
  }

  // Update
  // Komsan
  @override
  Future<void> updateProblem({
    required String id,
    String? title,
    String? detail,
    String? locationName,
    double? lat,
    double? lng,
    String? typeId,
    String? tagId,
  }) async {
    try {
      var mutation = connector.updateProblem(id: id);

      if (title != null) mutation = mutation.title(title);
      if (detail != null) mutation = mutation.detail(detail);
      if (locationName != null) mutation = mutation.locationName(locationName);
      if (lat != null) mutation = mutation.lat(lat);
      if (lng != null) mutation = mutation.lng(lng);
      if (typeId != null) mutation = mutation.typeId(typeId);
      if (tagId != null) mutation = mutation.tagId(tagId);

      await mutation.execute();
    } catch (e) {
      throw Exception("ไม่สามารถแก้ไขข้อมูลได้: $e");
    }
  }

  // Delete
  // Komsan
  @override
  Future<void> deleteProblem(String id) async {
    try {
      await connector.deleteProblem(id: id).execute();
    } catch (e) {
      throw Exception("ไม่สามารถลบข้อมูลได้: $e");
    }
  }

  @override
  Future<int> countProblemsByTag({required String currentTagId}) async {
    try {
      final result = await connector
          .problemsByTag(TagId: currentTagId)
          .execute();
      return result.data.problems.length;
    } catch (e) {
      throw Exception("ไม่สามารถนับจำนวนปัญหาตามแท็กได้: $e");
    }
  }
}
