import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

// Komsan
class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// อัพโหลดรูปภาพปัญหา
  Future<String> uploadProblemImage(File imageFile) async {
    try {
      // สร้างชื่อไฟล์ที่ไม่ซ้ำกัน
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = path.extension(imageFile.path);
      final String fileName = 'problem_$timestamp$extension';
      
      // กำหนด path ใน Storage
      final Reference storageRef = _storage
          .ref()
          .child('problem_images')
          .child(fileName);

      // อัพโหลดไฟล์
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      
      // รอให้อัพโหลดเสร็จ
      final TaskSnapshot snapshot = await uploadTask;
      
      // ดึง download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('ไม่สามารถอัพโหลดรูปภาพได้: $e');
    }
  }

  /// ลบรูปภาพ (ใช้เมื่อต้องการลบปัญหา)
  Future<void> deleteProblemImage(String imageUrl) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      // อาจจะไม่มีไฟล์อยู่แล้ว หรือเกิดข้อผิดพลาด
      print('ไม่สามารถลบรูปภาพได้: $e');
    }
  }
}