import 'package:flutter/material.dart';
import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/entities/problem_type_entity.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_type_usecase.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/delete_problem_usecase.dart';
import 'package:cmu_fondue/data/repositories/problem_type_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/problem_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/problem_tag_repo_impl.dart';
import 'package:cmu_fondue/domain/entities/problem_tag_entity.dart';

class CreateProblemPage extends StatefulWidget {
  const CreateProblemPage({super.key});

  @override
  State<CreateProblemPage> createState() => _CreateProblemPageState();
}

class _CreateProblemPageState extends State<CreateProblemPage> {
  final _formKey = GlobalKey<FormState>();

  // --- UseCases ---
  late GetProblemTypesUseCase _getProblemTypesUseCase;
  late CreateProblemUseCase _createProblemUseCase;
  late GetProblemsUseCase _getProblemsUseCase;
  late UpdateProblemUseCase _updateProblemUseCase;
  late DeleteProblemUseCase _deleteProblemUseCase;

  // --- States ---
  List<ProblemTypeEntity> _problemTypes = [];
  List<ProblemEntity> _existingProblems = [];

  String? _selectedTypeId;
  String? _editingProblemId; // ถ้าเป็น null = โหมดสร้าง, ถ้ามีค่า = โหมดแก้ไข

  bool _isLoading = true;
  bool _isSubmitting = false;

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
  final String mockReporterId =
      "11111111-2222-3333-4444-555555555555"; // อนาคตให้ดึงค่าจริง ๆ จาก state
  final String mockTagId =
      "d74d3f00-e2fb-4b71-9d06-1f4b336c56b7"; // "รับเรื่องแล้ว" จริง ๆ ควร Fix ไว้ สำหรับขา Create เลย

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
    final tagRepo = ProblemTagRepoImpl(connector: connector);

    _getProblemTypesUseCase = GetProblemTypesUseCase(typeRepo);
    _createProblemUseCase = CreateProblemUseCase(problemRepo);
    _getProblemsUseCase = GetProblemsUseCase(problemRepo);
    _updateProblemUseCase = UpdateProblemUseCase(problemRepo);
    _deleteProblemUseCase = DeleteProblemUseCase(problemRepo);
  }

  /// ดึงข้อมูลใหม่จาก Server ทั้ง Types, Problems, และ Tags
  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    try {
      final tagRepo = ProblemTagRepoImpl(connector: ConnectorConnector.instance);
      final results = await Future.wait([
        _getProblemTypesUseCase.call(),
        _getProblemsUseCase.call(),
        tagRepo.getAllProblemTags(),
      ]);
      setState(() {
        _problemTypes = results[0] as List<ProblemTypeEntity>;
        _existingProblems = results[1] as List<ProblemEntity>;

        // กำหนดค่า Default ให้ Dropdown ถ้ายังไม่มีการเลือก
        if (_problemTypes.isNotEmpty && _selectedTypeId == null) {
          _selectedTypeId = _problemTypes.first.problemTypeId;
        }
      });
      
      // โหลดจำนวนปัญหาแต่ละแท็ก
      await _loadTagCounts();
    } catch (e) {
      _showErrorSnackBar("โหลดข้อมูลไม่สำเร็จ: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// ดึงจำนวนปัญหาในแต่ละแท็ก
  Future<void> _loadTagCounts() async {
    final counts = <String, int>{};
    for (var tag in _problemTags) {
      try {
        final count = await _getProblemsUseCase.countByTag(tag.problemTagId);
        counts[tag.problemTagId] = count;
      } catch (e) {
        counts[tag.problemTagId] = 0;
      }
    }
    setState(() => _tagCounts = counts);
  }

  /// ล้างฟอร์มกลับเป็นค่าว่าง (สำหรับยกเลิกการแก้ไขหรือหลังส่งข้อมูล)
  void _clearForm() {
    setState(() {
      _editingProblemId = null;
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
    setState(() => _isSubmitting = true);

    try {
      if (_editingProblemId == null) {
        // --- โหมดสร้างใหม่ ---
        await _createProblemUseCase.call(
          title: _titleController.text,
          detail: _detailController.text,
          locationName: _locationNameController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lngController.text),
          reporterId: mockReporterId,
          typeId: _selectedTypeId!,
          tagId: mockTagId,
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
          tagId: mockTagId,
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

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
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
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
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
