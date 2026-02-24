import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

class ProblemRepoImpl implements ProblemRepo {
  final ConnectorConnector connector;
  ProblemRepoImpl({required this.connector});

  // Read
  // Komsan
  @override
  Future<List<ProblemEntity>> getProblems(String userId) async {
    try {
      // 1. เรียก Query จาก Data Connect SDK (ตัวอย่างชื่อ listProblems)
      final result = await connector.listProblems().execute();
      // 2. Map ข้อมูลจาก SDK Object ให้กลายเป็น Domain Entity
      // e ในที่นี้คือข้อมูลดิบที่มีความสัมพันธ์ (Nested Object) ติดมาด้วย
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e, userId);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาได้: $e");
    }
  }

  @override
  Future<List<ProblemEntity>> getNotCompletedProblems(String userId) async {
    try {
      final result = await connector.listNotCompletedProblems().execute();
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e, userId);
      }).toList();
    } catch (e) {
      if (e is DataConnectOperationError) {
        print('--- Data Connect Error Found ---');
        print('Code: ${e.code}');
        print('Message: ${e.message}');

        // ตัวนี้แหละครับที่จะบอกว่า "Instance of ..." คืออะไร
        final errorInfo = e.response;
        if (errorInfo != null) {
          // ลองพิมพ์ข้อมูลดิบจาก errorInfo
          print('Error Details: ${errorInfo.errors}');

          // ถ้ามี List ของ Errors ย่อยๆ ให้วน Loop ดู
          for (var graphQLError in errorInfo.errors) {
            print('--- GraphQL Error Detail ---');
            print('Message: ${graphQLError.message}');
          }
        }
      } else {
        print('Unknown Error: $e');
      }
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาได้: $e");
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

  @override
  Future<List<ProblemEntity>> getProblemsByTagAndType({
    required String tagId,
    required String typeId,
    String? userId,
  }) async {
    try {
      final result = await connector
          .problemsByTagAndType(TagId: tagId, TypeId: typeId)
          .execute();
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e, userId);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาตามแท็กและประเภทได้: $e");
    }
  }

  @override
  Future<List<ProblemEntity>> getProblemsByTag({
    required String tagId,
    String? userId,
  }) async {
    try {
      final result = await connector.problemsByTagFull(TagId: tagId).execute();
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e, userId);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาตามแท็กได้: $e");
    }
  }

  @override
  Future<List<ProblemEntity>> getProblemsByType({
    required String typeId,
    String? userId,
  }) async {
    try {
      final result = await connector
          .problemsByTypeFull(TypeId: typeId)
          .execute();
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e, userId);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาตามประเภทได้: $e");
    }
  }

  // Insert upvote
  // Rachata
  @override
  Future<void> addUpvote({required String id, required String userId}) async {
    try {
      await connector.addUpvote(problemId: id, userId: userId).execute();
    } catch (e) {
      throw Exception("ไม่สามารถเพิ่มคะแนนให้ปัญหาได้: $e");
    }
  }

  // Delete upvote
  // Rachata
  @override
  Future<void> removeUpvote({
    required String id,
    required String userId,
  }) async {
    try {
      await connector.removeUpvote(problemId: id, userId: userId).execute();
    } catch (e) {
      throw Exception("ไม่สามารถลบคะแนนให้ปัญหาได้: $e");
    }
  }
}
