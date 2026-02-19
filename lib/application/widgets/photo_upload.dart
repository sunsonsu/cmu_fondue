import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoUploadWidget extends StatelessWidget {
  final VoidCallback? onUploadPressed;
  final VoidCallback? onTakePhotoPressed;
  final File? selectedImage;

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
