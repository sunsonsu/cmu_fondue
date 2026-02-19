import 'dart:io';
import 'package:path/path.dart' as path;
import '../repositories/problem_repo.dart';
import '../repositories/problem_image_repo.dart';
import '../../data/services/FirebaseStorageService.dart';

// Komsan
class CreateProblemUseCase {
  final ProblemRepo problemRepository;
  final ProblemImageRepo problemImageRepository;
  final FirebaseStorageService storageService;

  CreateProblemUseCase({
    required this.problemRepository,
    required this.problemImageRepository,
    required this.storageService,
  });

  Future<String> call({
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
    required File imageFile,
  }) async {
    String? imageUrl;
    String? problemId;

    try {
      // 1. อัพโหลดรูปภาพไป Firebase Storage
      imageUrl = await storageService.uploadProblemImage(imageFile);

      // 2. สร้าง Problem record
      problemId = await problemRepository.createProblem(
        title: title,
        detail: detail,
        locationName: locationName,
        lat: lat,
        lng: lng,
        reporterId: reporterId,
        typeId: typeId,
        tagId: tagId,
      );

      // 3. สร้าง ProblemImage record เชื่อมกับ Problem record
      final String fileName = path.basename(imageFile.path);
      final String imageType = path.extension(imageFile.path)
          .replaceFirst('.', '')
          .toLowerCase();
      
      await problemImageRepository.createProblemImage(
        problemId: problemId,
        imageUrl: imageUrl,
        fileName: fileName,
        imageType: imageType.isEmpty ? 'jpg' : imageType,
      );

      return problemId;
      
    } catch (e) {
      // Rollback: ถ้าสร้าง Problem สำเร็จแล้วแต่สร้าง Image ไม่สำเร็จ
      if (problemId != null) {
        try {
          await problemRepository.deleteProblem(problemId);
        } catch (deleteError) {
          print('ไม่สามารถลบปัญหาที่สร้างไว้ได้: $deleteError');
        }
      }
      
      // Rollback: ลบรูปที่อัพโหลดไปแล้ว (ถ้าอัพโหลดสำเร็จแต่สร้าง Problem/Image ไม่สำเร็จ)
      if (imageUrl != null) {
        try {
          await storageService.deleteProblemImage(imageUrl);
        } catch (deleteError) {
          print('ไม่สามารถลบรูปภาพที่อัพโหลดไว้ได้: $deleteError');
        }
      }
      
      // Throw error ต้นฉบับเพื่อให้ UI จัดการต่อ
      rethrow;
    }
  }
}