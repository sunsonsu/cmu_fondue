/*
 * File: test_development_page.dart
 * Description: Scratchpad interface bypassing strict architectural protections entirely allowing unchecked experimental creations natively.
 * Responsibilities: 
 * - Injects malformed fake variables and manipulates isolated data nodes for testing.
 * - Forcibly evaluates remote endpoints and bypasses conventional provider mechanisms.
 * - Serves as a hidden testing ground for rapid prototyping of new features.
 * Author: Komsan 650510601
 * Course: Mobile Application Development Framework
 * Lifecycle: Created merely upon developer intent for feature prototyping, Disposed when returning to the standard user journey.
 * Notes: No UI logic should appear in this file. (Testing override context)
 */

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

/// Flouts conventional isolation layers strictly connecting isolated systems violently enabling unconstrained development hacking purely natively.
/// 
/// A development-only page providing direct access to data repositories and use cases.
class TestDevelopmentPage extends StatefulWidget {
  /// Initializes a new instance of [TestDevelopmentPage].
  const TestDevelopmentPage({super.key});

  @override
  State<TestDevelopmentPage> createState() => _TestDevelopmentPageState();
}

class _TestDevelopmentPageState extends State<TestDevelopmentPage> {
  /// Global key for the form state.
  final _formKey = GlobalKey<FormState>();

  /// Domain logic for fetching problem types.
  late GetProblemTypesUseCase _getProblemTypesUseCase;

  /// Domain logic for report creation.
  late CreateProblemUseCase _createProblemUseCase;

  /// Domain logic for report retrieval.
  late GetProblemsUseCase _getProblemsUseCase;

  /// Domain logic for report updates.
  late UpdateProblemUseCase _updateProblemUseCase;

  /// Domain logic for report deletion.
  late DeleteProblemUseCase _deleteProblemUseCase;

  /// Domain logic for reporting status changes to users.
  late NotifyProblemStatusChangedUseCase _notifyUseCase;

  /// Cached list of available problem types.
  List<ProblemTypeEntity> _problemTypes = [];

  /// Cached list of existing system problems.
  List<ProblemEntity> _existingProblems = [];

  /// The currently selected problem type ID in the form.
  String? _selectedTypeId;

  /// The ID of the problem currently being edited.
  String? _editingProblemId;

  /// The local file reference for the experimental image selection.
  File? _selectedImage;

  /// Whether the initial data load is active.
  bool _isLoading = true;

  /// Whether a data submission is currently in progress.
  bool _isSubmitting = false;

  /// The utility for selecting or capturing images from the device.
  final ImagePicker _imagePicker = ImagePicker();

  /// The controller for the test report title input.
  final _titleController = TextEditingController();

  /// The controller for the test report detail input.
  final _detailController = TextEditingController();

  /// The controller for the test report location name input.
  final _locationNameController = TextEditingController(
    text: "Computer science",
  );

  /// The controller for the test report latitude input.
  final _latController = TextEditingController(text: "18.7961");

  /// The controller for the test report longitude input.
  final _lngController = TextEditingController(text: "98.9520");

  /// A mock user ID used for development reporting bypasses.
  final String mockReporterId = "nGdg0vtmLMeEQs2ZHmAKPsp4K0A3";

  @override
  void initState() {
    super.initState();
    _initDependencies();
    _refreshData();
  }

  /// Initializes required domain controllers for rapid debugging.
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

  /// Evaluates entirely independent queries combining disjoint streams directly overriding proper provider mechanisms forcibly statically.
  ///
  /// This operates asynchronously initiating deep architecture queries securely hooking local operating systems distinctly isolating failures gracefully.
  ///
  /// Side effects:
  /// Violently replaces local [_problemTypes] and [_existingProblems] arrays natively firing [setState].
  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _getProblemTypesUseCase.call(),
        _getProblemsUseCase.call(''),
      ]);
      setState(() {
        _problemTypes = results[0] as List<ProblemTypeEntity>;
        _existingProblems = results[1] as List<ProblemEntity>;

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

  /// Triggers generic multimedia abstractions circumventing normal verification pathways directly forcefully locally.
  ///
  /// This operates asynchronously demanding formal explicit queries hooking local hardware directly bypassing limits natives.
  ///
  /// Side effects:
  /// Rewrites the active [_selectedImage] formally dropping bytes temporarily firing [setState] exactly.
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

  /// Casts disjoint visual abstractions floating over experimental layouts distinct natively.
  /// 
  /// Displays an options picker for selecting between gallery and camera sources.
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

  /// Flushes native forms comprehensively blanking fake constraints securely cleanly.
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

  /// Injects active values aggressively directly editing isolated objects completely unverified locally.
  /// 
  /// Populates the test form with existing [problem] metadata for modification.
  void _onEditSelected(ProblemEntity problem) {
    setState(() {
      _editingProblemId = problem.id;
      _titleController.text = problem.title;
      _detailController.text = problem.detail;
      _latController.text = problem.lat.toString();
      _lngController.text = problem.lng.toString();

      try {
        _selectedTypeId = _problemTypes
            .firstWhere((t) => t.typeThaiName == problem.typeName)
            .problemTypeId;
      } catch (_) {}
    });
    Scrollable.ensureVisible(_formKey.currentContext!);
  }

  /// Commits raw objects entirely explicitly manipulating endpoints regardless directly completely natively.
  ///
  /// This operates asynchronously violently creating architectural instances cleanly explicitly forcing cloud updates unverified.
  /// 
  /// Executes the creation or update logic depending on whether [_editingProblemId] is set.
  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || _selectedTypeId == null) return;

    if (_editingProblemId == null && _selectedImage == null) {
      _showErrorSnackBar("กรุณาเลือกรูปภาพ");
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      if (_editingProblemId == null) {
        final tagRepo = ProblemTagRepoImpl(
          connector: ConnectorConnector.instance,
        );
        final allTags = await tagRepo.getAllProblemTags();

        final defaultTag = allTags.firstWhere(
          (tag) => tag.tagName.toLowerCase() == 'pending',
          orElse: () => allTags.first,
        );

        await _createProblemUseCase.call(
          title: _titleController.text,
          detail: _detailController.text,
          locationName: _locationNameController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text),
          reporterId: mockReporterId,
          typeId: _selectedTypeId!,
          tagId: defaultTag.problemTagId,
          imageFile: _selectedImage!,
        );
      } else {
        await _updateProblemUseCase.call(
          id: _editingProblemId!,
          title: _titleController.text,
          detail: _detailController.text,
          locationName: _locationNameController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text),
          typeId: _selectedTypeId!,
          tagId: null,
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

  /// Nukes valid data outright violently purging nodes securely natively explicitly verifying locally.
  ///
  /// This operates asynchronously initiating deep architecture queries securely hooking local operating systems distinctly isolating failures gracefully.
  /// 
  /// Deletes the problem with the specified [id].
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

  /// Asserts fake system tests demanding explicit cloud messaging paths securely correctly checking variables manually.
  ///
  /// This operates asynchronously requesting foreign data networks distinctly actively.
  /// 
  /// Tests FCM notification delivery for the specified [problem].
  Future<void> _testSendNotification(ProblemEntity problem) async {
    final notificationService = NotificationService();
    final fcmToken = await notificationService.getFcmToken();

    if (fcmToken == null || fcmToken.isEmpty) {
      _showErrorSnackBar("ไม่พบ FCM Token กรุณาตรวจสอบการตั้งค่า");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await _notifyUseCase.execute(
        problemId: problem.id,
        problemTitle: problem.title,
        newTagName: "กำลังดำเนินการ (ทดสอบ)",
        fcmToken: fcmToken,
      );

      if (mounted) Navigator.pop(context);
      _showSuccessSnackBar("ส่ง Notification สำเร็จ! ตรวจสอบที่เครื่องของคุณ");
    } catch (e) {
      if (mounted) Navigator.pop(context);

      final errorMessage = e.toString();
      if (errorMessage.contains('unauthenticated') ||
          errorMessage.contains('UNAUTHENTICATED')) {
        _showErrorDialog(
          "กรุณา Login ก่อน\n\n"
          "Firebase Functions ต้องการให้คุณเข้าสู่ระบบก่อนส่ง notification\n\n"
          "กรุณา logout และ login อีกครั้ง หรือรีสตาร์ท app",
        );
      } else {
        _showErrorDialog("ส่ง Notification ไม่สำเร็จ: $e");
      }
    }
  }

  /// Displays simple success feedback to the developer.
  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    CustomSnackBar.showSuccess(context: context, message: message);
  }

  /// Displays error feedback via snackbar for rapid troubleshooting.
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    CustomSnackBar.showError(context: context, message: message);
  }

  /// Displays detailed error explanations via modal dialog.
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 18,
                                            ),
                                            label: const Text('เปลี่ยนรูป'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white
                                                  .withOpacity(0.9),
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
