/*
 * File: FirebaseStorageService.dart
 * Description: Interacts directly with Firebase Storage for media asset handling.
 * Responsibilities: Handles file uploads, generates unique filenames, maps remote URLs, and deletes binary assets.
 * Author: Komsan
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

/// Provides direct interface control for uploading and removing unstructured file data securely.
class FirebaseStorageService {
  /// The underlying Firebase Storage bucket reference.
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads a local [imageFile] to the remote problem images directory.
  ///
  /// This operates asynchronously across the network. Computes a unique tracking
  /// filename using current epoch milliseconds.
  /// Returns the complete resolvable download URL if successful.
  /// Throws a generic exception encapsulating any core Firebase failure.
  Future<String> uploadProblemImage(File imageFile) async {
    try {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = path.extension(imageFile.path);
      final String fileName = 'problem_$timestamp$extension';
      
      final Reference storageRef = _storage
          .ref()
          .child('problem_images')
          .child(fileName);

      final UploadTask uploadTask = storageRef.putFile(imageFile);
      
      final TaskSnapshot snapshot = await uploadTask;
      
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('ไม่สามารถอัพโหลดรูปภาพได้: $e');
    }
  }

  /// Requests the deletion of a specific file identified by its [imageUrl].
  ///
  /// This operates asynchronously. Failure modes (like the file already being removed)
  /// are deliberately caught and ignored to allow for idempotent cleanup routines.
  ///
  /// Side effects:
  /// Permanently erases the file from cloud storage buckets.
  Future<void> deleteProblemImage(String imageUrl) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      print('ไม่สามารถลบรูปภาพได้: $e');
    }
  }
}