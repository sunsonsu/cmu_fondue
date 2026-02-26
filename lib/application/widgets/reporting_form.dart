import 'dart:io';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmu_fondue/application/widgets/photo_upload.dart';

class ReportingForm extends StatefulWidget {
  final String location;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ValueChanged<ProblemType?> onCategoryChanged;
  final ProblemType? selectedCategory;
  final File? selectedImage;
  final VoidCallback onPickImageFromGallery;
  final VoidCallback onTakePicture;

  const ReportingForm({
    super.key,
    required this.location,
    required this.titleController,
    required this.descriptionController,
    required this.onCategoryChanged,
    required this.onPickImageFromGallery,
    required this.onTakePicture,
    this.selectedCategory,
    this.selectedImage,
  });

  @override
  State<ReportingForm> createState() => _ReportingFormState();
}

class _ReportingFormState extends State<ReportingForm> {
  final List<ProblemType> _categories = ProblemType.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location Section
        Text(
          'Your Location',
          style: GoogleFonts.kanit(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          widget.location,
          style: GoogleFonts.kanit(fontSize: 16, fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 24),

        // Title Field
        RichText(
          text: TextSpan(
            text: 'ชื่อเรื่อง',
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
        const SizedBox(height: 8),
        TextField(
          controller: widget.titleController,
          maxLength: 50,
          decoration: InputDecoration(
            hintText: 'ระบุหัวข้อ เช่น ประตูเสียที่คณะวิทยาศาสตร์',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF5D3891), width: 2),
            ),
            counterText: '${widget.titleController.text.length}/50',
            contentPadding: const EdgeInsets.all(16),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),

        const SizedBox(height: 24),

        // Category Field
        RichText(
          text: TextSpan(
            text: 'หมวดหมู่',
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
        const SizedBox(height: 8),
        Text(
          'เลือกหมวดหมู่เพียง 1 หมวดหมู่เท่านั้น',
          style: GoogleFonts.kanit(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _categories.map((category) {
            final isSelected = widget.selectedCategory == category;
            return GestureDetector(
              onTap: () {
                widget.onCategoryChanged(category);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF5D3891) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF5D3891)
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Text(
                  category.labelTh,
                  style: GoogleFonts.kanit(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Description Field
        RichText(
          text: TextSpan(
            text: 'คำอธิบาย',
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
        const SizedBox(height: 8),
        TextField(
          controller: widget.descriptionController,
          maxLength: 255,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'เขียนคำอธิบายเหตุการณ์พอสังเขป',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF5D3891), width: 2),
            ),
            counterText: '${widget.descriptionController.text.length}/255',
            contentPadding: const EdgeInsets.all(16),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),

        const SizedBox(height: 24),

        // Upload Photo Section
        PhotoUploadWidget(
          selectedImage: widget.selectedImage,
          onUploadPressed: widget.onPickImageFromGallery,
          onTakePhotoPressed: widget.onTakePicture,
        ),
      ],
    );
  }
}
