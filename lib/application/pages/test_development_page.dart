import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_type_usecase.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/delete_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/notify_problem_status_changed_usecase.dart';
import 'package:cmu_fondue/data/repositories/problem_type_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/problem_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/problem_image_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/problem_tag_repo_impl.dart';
import 'package:cmu_fondue/data/services/FirebaseStorageService.dart';
import 'package:cmu_fondue/data/services/cloud_functions_service.dart';
import 'package:cmu_fondue/data/services/notification_service.dart';

class TestDevelopmentPage extends StatefulWidget {
  const TestDevelopmentPage({super.key});

  @override
  State<TestDevelopmentPage> createState() => _TestDevelopmentPageState();
}

class _TestDevelopmentPageState extends State<TestDevelopmentPage> {
  final _formKey = GlobalKey<FormState>();

  // --- UseCases ---
  late GetProblemTypesUseCase _getProblemTypesUseCase;
  late CreateProblemUseCase _createProblemUseCase;
  late GetProblemsUseCase _getProblemsUseCase;
  late UpdateProblemUseCase _updateProblemUseCase;
  late DeleteProblemUseCase _deleteProblemUseCase;
  late NotifyProblemStatusChangedUseCase _notifyUseCase;

  // --- States ---
  List<ProblemTypeEntity> _problemTypes = [];
  List<ProblemEntity> _existingProblems = [];

  String? _selectedTypeId;
  String? _editingProblemId; // ถ้าเป็น null = โหมดสร้าง, ถ้ามีค่า = โหมดแก้ไข
  File? _selectedImage; // รูปภาพที่เลือก

  bool _isLoading = true;
  bool _isSubmitting = false;

  final ImagePicker _imagePicker = ImagePicker();

  // --- Controllers ---
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _locationNameController = TextEditingController(
    text: "Computer science",
  );

  // --- Mock Data --- // อนาคตต้องแก้เปล็น
  final _latController = TextEditingController(
    text: "18.7961",
  ); // ต้องดึงจากตำแหน่งจริง ๆ ในอนาคต หรือให้ผู้ใช้เลือกบนแผนที่
  final _lngController = TextEditingController(
    text: "98.9520",
  ); // ต้องดึงจากตำแหน่งจริง ๆ ในอนาคต หรือให้ผู้ใช้เลือกบนแผนที่
  
  // ใช้ userId ที่มีอยู่ในระบบจริง (จาก seed data)
  final String mockReporterId = "nGdg0vtmLMeEQs2ZHmAKPsp4K0A3"; // admin@test.com

  @override
  void initState() {
    super.initState();
    _initDependencies();
    _refreshData();
  }

  void _initDependencies() {
    final connector = ConnectorConnector.instance;
    final typeRepo = ProblemTypeRepoImpl(connector: connector);
    final problemRepo = ProblemRepoImpl(connector: connector);
    final problemImageRepo = ProblemImageRepoImpl(connector: connector);
    final storageService = FirebaseStorageService();
    final cloudFunctionsService = CloudFunctionsService();

    _getProblemTypesUseCase = GetProblemTypesUseCase(typeRepo);
    _createProblemUseCase = CreateProblemUseCase(
      problemRepository: problemRepo,
      problemImageRepository: problemImageRepo,
      storageService: storageService,
    );
    _getProblemsUseCase = GetProblemsUseCase(problemRepo);
    _updateProblemUseCase = UpdateProblemUseCase(problemRepo);
    _deleteProblemUseCase = DeleteProblemUseCase(problemRepo);
    _notifyUseCase = NotifyProblemStatusChangedUseCase(cloudFunctionsService);
  }

  /// ดึงข้อมูลใหม่จาก Server ทั้ง Types และ Problems
  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _getProblemTypesUseCase.call(),
        _getProblemsUseCase.call(),
      ]);
      setState(() {
        _problemTypes = results[0] as List<ProblemTypeEntity>;
        _existingProblems = results[1] as List<ProblemEntity>;

        // กำหนดค่า Default ให้ Dropdown ถ้ายังไม่มีการเลือก
        if (_problemTypes.isNotEmpty && _selectedTypeId == null) {
          _selectedTypeId = _problemTypes.first.problemTypeId;
        }
      });
    } catch (e) {
      _showErrorSnackBar("โหลดข้อมูลไม่สำเร็จ: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// เลือกรูปภาพจาก Gallery หรือ Camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorSnackBar("ไม่สามารถเลือกรูปภาพได้: $e");
    }
  }

  /// แสดง Dialog เลือกแหล่งที่มาของรูปภาพ
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('เลือกจากคลังรูปภาพ'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('ถ่ายรูปใหม่'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ล้างฟอร์มกลับเป็นค่าว่าง (สำหรับยกเลิกการแก้ไขหรือหลังส่งข้อมูล)
  void _clearForm() {
    setState(() {
      _editingProblemId = null;
      _selectedImage = null;
      _titleController.clear();
      _detailController.clear();
      _latController.text = "18.7961";
      _lngController.text = "98.9520";
    });
  }

  /// เตรียมข้อมูลเพื่อการแก้ไข
  void _onEditSelected(ProblemEntity problem) {
    setState(() {
      _editingProblemId = problem.id;
      _titleController.text = problem.title;
      _detailController.text = problem.detail;
      _latController.text = problem.lat.toString();
      _lngController.text = problem.lng.toString();

      // ค้นหา Type ID ที่ชื่อตรงกับใน Entity
      try {
        _selectedTypeId = _problemTypes
            .firstWhere((t) => t.typeThaiName == problem.typeName)
            .problemTypeId;
      } catch (_) {}
    });
    // เลื่อนหน้าจอขึ้นไปบนสุดเพื่อให้เห็น Form
    Scrollable.ensureVisible(_formKey.currentContext!);
  }

  /// จัดการการส่งข้อมูล (ทั้ง Create และ Update)
  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || _selectedTypeId == null) return;
    
    // ตรวจสอบว่ามีรูปภาพหรือไม่ (สำหรับโหมดสร้างใหม่)
    if (_editingProblemId == null && _selectedImage == null) {
      _showErrorSnackBar("กรุณาเลือกรูปภาพ");
      return;
    }
    
    setState(() => _isSubmitting = true);

    try {
      if (_editingProblemId == null) {
        // ดึง Tag "pending" ที่มีอยู่จริงจากระบบ
        final tagRepo = ProblemTagRepoImpl(connector: ConnectorConnector.instance);
        final allTags = await tagRepo.getAllProblemTags();
        
        // หา tag ที่ชื่อว่า "pending" หรือใช้ tag แรกถ้าไม่เจอ
        final defaultTag = allTags.firstWhere(
          (tag) => tag.tagName.toLowerCase() == 'pending',
          orElse: () => allTags.first,
        );

        // --- โหมดสร้างใหม่ (ต้องมีรูปภาพ) ---
        await _createProblemUseCase.call(
          title: _titleController.text,
          detail: _detailController.text,
          locationName: _locationNameController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text),
          reporterId: mockReporterId,
          typeId: _selectedTypeId!, // ใช้ ID จาก dropdown ที่ดึงมาจากระบบจริง
          tagId: defaultTag.problemTagId, // ใช้ tag ID ที่มีอยู่จริง
          imageFile: _selectedImage!,
        );
      } else {
        // --- โหมดอัปเดต ---
        await _updateProblemUseCase.call(
          id: _editingProblemId!,
          title: _titleController.text,
          detail: _detailController.text,
          locationName: _locationNameController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text),
          typeId: _selectedTypeId!,
          tagId: null, // ไม่เปลี่ยน tag เมื่ออัปเดต (ต้องให้ admin เปลี่ยน)
        );
      }

      _clearForm();
      await _refreshData();
      _showSuccessSnackBar("บันทึกข้อมูลเรียบร้อยแล้ว");
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  /// จัดการการลบข้อมูล
  Future<void> _handleDelete(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("ยืนยันการลบ"),
        content: const Text("คุณแน่ใจหรือไม่ว่าต้องการลบรายการนี้?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("ยกเลิก"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("ลบ", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      try {
        await _deleteProblemUseCase.call(id);
        await _refreshData();
        _showSuccessSnackBar("ลบข้อมูลสำเร็จ");
      } catch (e) {
        _showErrorDialog("ลบไม่สำเร็จ: $e");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  /// ทดสอบส่ง Push Notification
  Future<void> _testSendNotification(ProblemEntity problem) async {
    // ดึง FCM Token ของตัวเอง (เพื่อทดสอบ)
    final notificationService = NotificationService();
    final fcmToken = await notificationService.getFcmToken();

    if (fcmToken == null || fcmToken.isEmpty) {
      _showErrorSnackBar("ไม่พบ FCM Token กรุณาตรวจสอบการตั้งค่า");
      return;
    }

    // แสดง loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await _notifyUseCase.execute(
        problemId: problem.id,
        problemTitle: problem.title,
        newTagName: "กำลังดำเนินการ (ทดสอบ)",
        fcmToken: fcmToken,
      );
      
      if (mounted) Navigator.pop(context); // ปิด loading dialog
      _showSuccessSnackBar("ส่ง Notification สำเร็จ! ตรวจสอบที่เครื่องของคุณ");
    } catch (e) {
      if (mounted) Navigator.pop(context); // ปิด loading dialog
      
      // ตรวจสอบ error type
      final errorMessage = e.toString();
      if (errorMessage.contains('unauthenticated') || 
          errorMessage.contains('UNAUTHENTICATED')) {
        _showErrorDialog(
          "กรุณา Login ก่อน\n\n"
          "Firebase Functions ต้องการให้คุณเข้าสู่ระบบก่อนส่ง notification\n\n"
          "กรุณา logout และ login อีกครั้ง หรือรีสตาร์ท app"
        );
      } else {
        _showErrorDialog("ส่ง Notification ไม่สำเร็จ: $e");
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    CustomSnackBar.showSuccess(
      context: context,
      message: message,
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    CustomSnackBar.showError(
      context: context,
      message: message,
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("เกิดข้อผิดพลาด"),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingProblemId == null ? "แจ้งปัญหาใหม่" : "แก้ไขปัญหา"),
        backgroundColor: _editingProblemId == null
            ? Colors.blue
            : Colors.orange,
        actions: [
          if (_editingProblemId != null)
            IconButton(icon: const Icon(Icons.close), onPressed: _clearForm),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // --- ส่วนของ FORM ---
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[100],
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: "หัวข้อปัญหา",
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (v) =>
                              v!.isEmpty ? "กรุณากรอกหัวข้อ" : null,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedTypeId,
                          decoration: const InputDecoration(
                            labelText: "ประเภทปัญหา",
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          items: _problemTypes
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type.problemTypeId,
                                  child: Text(type.typeThaiName),
                                ),
                              )
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _selectedTypeId = val),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _detailController,
                          decoration: const InputDecoration(
                            labelText: "รายละเอียด",
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 15),
                        
                        // --- ส่วนแสดงและเลือกรูปภาพ ---
                        if (_editingProblemId == null) ...[
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _selectedImage == null
                                ? InkWell(
                                    onTap: _showImageSourceDialog,
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          size: 64,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'แตะเพื่อเลือกรูปภาพ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          _selectedImage!,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _selectedImage = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      if (_selectedImage != null)
                                        Positioned(
                                          bottom: 8,
                                          right: 8,
                                          child: ElevatedButton.icon(
                                            onPressed: _showImageSourceDialog,
                                            icon: const Icon(Icons.edit, size: 18),
                                            label: const Text('เปลี่ยนรูป'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white.withOpacity(0.9),
                                              foregroundColor: Colors.black87,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 15),
                        ],
                        
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitData,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: _editingProblemId == null
                                ? Colors.blue
                                : Colors.orange,
                          ),
                          child: Text(
                            _isSubmitting
                                ? "กำลังบันทึก..."
                                : (_editingProblemId == null
                                      ? "ส่งข้อมูล"
                                      : "อัปเดตข้อมูล"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "รายการปัญหาในระบบ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                // --- ส่วนของ LIST ---
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      itemCount: _existingProblems.length,
                      itemBuilder: (context, index) {
                        final p = _existingProblems[index];
                        final imageUrl = p.imageUrl;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: ListTile(
                            leading: imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrl,
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const CircleAvatar(
                                              child: Icon(Icons.location_on),
                                            );
                                          },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return const SizedBox(
                                              width: 56,
                                              height: 56,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            );
                                          },
                                    ),
                                  )
                                : const CircleAvatar(
                                    child: Icon(Icons.location_on),
                                  ),
                            title: Text(
                              p.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${p.typeName} • ${p.tagName}\n${p.detail}",
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.notifications_active,
                                    color: Colors.blue,
                                  ),
                                  tooltip: "ทดสอบส่ง Notification",
                                  onPressed: () => _testSendNotification(p),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () => _onEditSelected(p),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _handleDelete(p.id),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }
}
