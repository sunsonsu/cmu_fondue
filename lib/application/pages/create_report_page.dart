import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cmu_fondue/application/widgets/reporting_form.dart';
import 'package:cmu_fondue/application/pages/history_page.dart';

class CreateReportPage extends StatefulWidget {
  final String location;

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
    // Request photo library permission
    final status = await Permission.photos.request();

    if (status.isGranted || status.isLimited) {
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('เกิดข้อผิดพลาด: $e')));
        }
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('กรุณาอนุญาตการเข้าถึงรูปภาพในการตั้งค่า'),
            duration: Duration(seconds: 3),
          ),
        );
        if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      }
    }
  }

  Future<void> _takePicture() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('เกิดข้อผิดพลาด: $e')));
        }
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('กรุณาอนุญาตการเข้าถึงกล้องในการตั้งค่า'),
            duration: Duration(seconds: 3),
          ),
        );
        if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'แจ้งปัญหา',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Form Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ReportingForm(
                location: widget.location,
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
                  onPressed:
                      _titleController.text.isNotEmpty &&
                          _selectedCategory != null &&
                          _descriptionController.text.isNotEmpty
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Scaffold(body: const HistoryPage()),
                            ),
                          );
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
                    'ถัดไป',
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
    );
  }
}
