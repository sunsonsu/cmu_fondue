import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

class ProblemRepoImpl implements ProblemRepo {
  final ConnectorConnector connector;
  ProblemRepoImpl({required this.connector});

  //Read
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

  //Create
  @override
  Future<String> createProblem({
    required String title,
    required String detail,
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
          lat: lat,
          lng: lng,
          reporterId: reporterId,
          typeId: typeId,
          tagId: tagId,
        )
        .execute();

    return result.data.problem_insert.problemId;
  }

  //Update
  @override
  Future<void> updateProblem({
    required String id,
    required String title,
    required String detail,
    required double lat,
    required double lng,
    required String typeId,
    required String tagId,
  }) async {
    try {
      await connector
          .updateProblem(
            id: id,
            title: title,
            detail: detail,
            lat: lat,
            lng: lng,
            typeId: typeId,
            tagId: tagId,
          )
          .execute();
    } catch (e) {
      throw Exception("ไม่สามารถแก้ไขข้อมูลได้: $e");
    }
  }

  //Delete
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
      final result = await connector.problemsByTag(TagId: currentTagId).execute();
      return result.data.problems.length;
    } catch (e) {
      throw Exception("ไม่สามารถนับจำนวนปัญหาตามแท็กได้: $e");
    }
  }

}
