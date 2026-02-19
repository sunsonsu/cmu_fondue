import 'dart:io';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cmu_fondue/application/widgets/reporting_form.dart';
import 'package:cmu_fondue/application/pages/history_page.dart';
import 'package:provider/provider.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';

class CreateReportPage extends StatefulWidget {
  final CmuPlaceEntity location;

  const CreateReportPage({super.key, required this.location});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context: context,
          message: 'เลือกรูปภาพไม่สำเร็จ',
        );
      }
    }
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context: context, message: 'ถ่ายรูปไม่สำเร็จ');
      }
    }
  }

  bool _isFormValid() {
    return _titleController.text.isNotEmpty &&
        _selectedCategory != null &&
        _descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3891)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'แจ้งปัญหา',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            // Form Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: ReportingForm(
                location: widget.location.formattedAddress,
                titleController: _titleController,
                descriptionController: _descriptionController,
                selectedCategory: _selectedCategory,
                selectedImage: _selectedImage,
                onCategoryChanged: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                onPickImageFromGallery: _pickImageFromGallery,
                onTakePicture: _takePicture,
                ),
              ),
            ),

            // Next Button
            Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFormValid()
                      ? () async {
                          // ดึง Provider แบบ listen: false เพราะเรียกใช้ในฟังก์ชันกดปุ่ม
                          // final probProvider = Provider.of<ProblemProvider>(
                          //   context,
                          //   listen: false,
                          // );
                          // final authProvider = Provider.of<AppAuthProvider>(
                          //   context,
                          //   listen: false,
                          // );

                          // // ตรวจสอบว่ามี UserId หรือยัง (กรณีใช้ Firebase Auth)
                          // if (authProvider.user?.id == "") {
                          //   CustomSnackBar.showWarning(
                          //     context: context,
                          //     message: 'กรุณาเข้าสู่ระบบก่อนแจ้งปัญหา',
                          //   );
                          //   return;
                          // }

                          // try {
                          //   // เรียกใช้ฟังก์ชันใน Provider ที่เราเตรียม UseCase ไว้แล้ว
                          //   await probProvider.createProblem(
                          //     title: _titleController.text,
                          //     detail: _descriptionController.text,
                          //     locationName:
                          //         widget.location, // ใช้ค่าจากตัวแปรที่รับมา
                          //     lat: 18.8001, // ในอนาคตควรดึงจาก GPS จริง
                          //     lng: 98.9502,
                          //     reporterId: authProvider.user.id
                          //         "",
                          //     typeId:
                          //         _selectedCategory!, // ส่ง ID ของ Category ไป
                          //     tagId:
                          //         "519a08f6-ee74-4b2b-870e-b35c951c8ee8", // ID 'ยังไม่ได้แก้ไข' จาก Seed
                          //   );

                          //   if (context.mounted) {
                          //     CustomSnackBar.showSuccess(
                          //       context: context,
                          //       message: 'สร้างรายงานสำเร็จ',
                          //     );
                          //
                          //     // เมื่อสำเร็จ ให้ไปหน้า History โดยล้าง Stack เดิมทิ้ง
                          //     await Future.delayed(const Duration(milliseconds: 500));
                          //     if (context.mounted) {
                          //       Navigator.pushAndRemoveUntil(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => const HistoryPage(),
                          //         ),
                          //         (route) => false,
                          //       );
                          //     }
                          //   }
                          // } catch (e) {
                          //   if (context.mounted) {
                          //     CustomSnackBar.showError(
                          //       context: context,
                          //       message: 'ไม่สามารถสร้างรายงานได้',
                          //     );
                          //   }
                          // }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF5D3891),
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'สร้างรายงาน',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          _titleController.text.isNotEmpty &&
                              _selectedCategory != null &&
                              _descriptionController.text.isNotEmpty
                          ? Colors.white
                          : Colors.grey[600],
                    ),
                  ),
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
