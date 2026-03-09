/*
 * File: photo_upload.dart
 * Description: A widget that provides photo upload functionality for problem reports.
 * Responsibilities: Displays image placeholder or preview, handles gallery upload and camera capture callbacks, validates supported file types (.png, .jpg, .jpeg, .HEIC).
 * Dependencies: Flutter, Google Fonts
 * Lifecycle: Created as part of the create report page, Stateless widget rebuilt when selectedImage changes.
 * Author: Chananchida
 * Course: CMU Fondue
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget that provides photo upload functionality for problem reports.
///
/// Displays either:
/// - A placeholder view with upload and camera buttons when no image is
///   selected.
/// - A preview of the selected image with options to re-select or retake
///   the photo.
///
/// Supported file types: `.png`, `.jpg`, `.jpeg`, `.HEIC`.
///
/// {@category Widgets}
class PhotoUploadWidget extends StatelessWidget {
  /// Callback invoked when the user presses the upload (gallery) button.
  final VoidCallback? onUploadPressed;

  /// Callback invoked when the user presses the take photo (camera) button.
  final VoidCallback? onTakePhotoPressed;

  /// The currently selected image file, or `null` if no image is selected.
  final File? selectedImage;

  /// Creates a [PhotoUploadWidget].
  ///
  /// All parameters are optional:
  /// - [onUploadPressed] handles gallery selection.
  /// - [onTakePhotoPressed] handles camera capture.
  /// - [selectedImage] displays a preview when provided.
  const PhotoUploadWidget({
    super.key,
    this.onUploadPressed,
    this.onTakePhotoPressed,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'อัปโหลดรูปภาพ',
            style: GoogleFonts.kanit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '*',
                style: GoogleFonts.kanit(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: selectedImage != null
              ? Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        selectedImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: onUploadPressed,
                            icon: const Icon(Icons.photo_library, size: 20),
                            label: Text(
                              'เลือกรูปใหม่',
                              style: GoogleFonts.kanit(fontSize: 14),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF5D3891),
                              side: const BorderSide(color: Color(0xFF5D3891)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: onTakePhotoPressed,
                            icon: const Icon(Icons.camera_alt, size: 20),
                            label: Text(
                              'ถ่ายรูปใหม่',
                              style: GoogleFonts.kanit(fontSize: 14),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF5D3891),
                              side: const BorderSide(color: Color(0xFF5D3891)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      'เพิ่มรูปภาพประกอบปัญหา',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 60,
                      color: const Color(0xFF5D3891),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'เฉพาะไฟล์ .png, .jpg, .jpeg, .HEIC',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onUploadPressed,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF5D3891),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'อัปโหลดรูปภาพ',
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: onTakePhotoPressed,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: Color(0xFF5D3891),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'ถ่ายรูปจากกล้อง',
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5D3891),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
