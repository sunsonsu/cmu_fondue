/*
 * File: problem_repo_impl.dart
 * Description: Concrete implementation of the ProblemRepo.
 * Responsibilities: Executes the core CRUD and querying logic against problems traversing the Data Connect SDK.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

/// Implements domain constraints for problem records utilizing the generated Firebase Data SDK.
class ProblemRepoImpl implements ProblemRepo {
  /// The generated connector executing direct GraphQL queries.
  final ConnectorConnector connector;

  /// Initializes a new instance of [ProblemRepoImpl].
  ProblemRepoImpl({required this.connector});

  @override
  Future<List<ProblemEntity>> getProblems(String userId) async {
    try {
      final result = await connector.listProblems().execute();
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

        final errorInfo = e.response;
        if (errorInfo != null) {
          print('Error Details: ${errorInfo.errors}');
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

  @override
  Future<void> addUpvote({required String id, required String userId}) async {
    try {
      await connector.addUpvote(problemId: id, userId: userId).execute();
    } catch (e) {
      throw Exception("ไม่สามารถเพิ่มคะแนนให้ปัญหาได้: $e");
    }
  }

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

  @override
  Future<ProblemEntity> getMaxUpvotedProblem(String userId) async {
    try {
      final result = await connector.maxUpvoteProblem().execute();
      if (result.data.problems.isEmpty) {
        throw Exception("ไม่พบปัญหาที่มีคะแนนสูงสุด");
      }
      return ProblemEntity.fromGenerated(result.data.problems.first, userId);
    } catch (e) {
      throw Exception("ไม่สามารถดึงปัญหาที่มีคะแนนสูงสุดได้: $e");
    }
  }

  @override
  Future<List<ProblemEntity>> getProblemsByReporter({
    required String reporterId,
    required String currentUserId,
  }) async {
    try {
      final result = await connector.listProblemsByReporter(reporterId: reporterId).execute();
      return result.data.problems.map((e) {
        return ProblemEntity.fromGenerated(e, currentUserId);
      }).toList();
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูลปัญหาของผู้ใช้ได้: $e");
    }
  }
}
