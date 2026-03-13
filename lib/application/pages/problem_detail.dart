/*
 * File: problem_detail.dart
 * Description: The comprehensive inspection interface displaying all granular metadata mapping individual incidents.
 * Responsibilities: 
 * - Renders text descriptions, loaded images, and status timelines for specific reports.
 * - Facilitates administrator resolutions and status transitions securely.
 * - Integrates geographic maps for precise pinpointing of reported anomalies.
 * Author: Rachata 650510638 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created strictly upon explicit selection from list views dynamically, Disposed immediately after backwards navigation unconditionally.
 */

import 'dart:io';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:cmu_fondue/application/widgets/delete_confirmation_dialog.dart';
import 'package:cmu_fondue/application/widgets/admin_status_management.dart';
import 'package:cmu_fondue/application/widgets/problem_location_map.dart';
import 'package:cmu_fondue/application/widgets/photo_upload.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

/// Aggregates granular incident metadata facilitating spatial verification alongside administrator-exclusive state transitions deeply natively.
/// 
/// Displays detailed information about a specific [problem], including its title, 
/// category, status, location, and supporting imagery.
class ProblemDetailPage extends StatefulWidget {
  /// The isolated conceptual chunk demanding deep inspection visually.
  final ProblemEntity problem;

  /// Initializes a new instance of [ProblemDetailPage].
  const ProblemDetailPage({super.key, required this.problem});

  @override
  State<ProblemDetailPage> createState() => _ProblemDetailPageState();
}

class _ProblemDetailPageState extends State<ProblemDetailPage> {
  /// The local file reference for the image captured upon problem completion.
  File? _completedImage;

  /// A temporary file holder during the photo selection dialog.
  File? _tempImage;

  /// The utility for selecting or capturing images from the device.
  final ImagePicker _picker = ImagePicker();

  /// The current status of the problem, overriding the entity value if updated locally.
  ProblemTag? _currentStatus;

  /// The timestamp when the status was last updated in the current session.
  DateTime? _statusUpdatedAt;

  /// Whether a status update or deletion process is currently in progress.
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.problem.tagName;
  }

  /// Evaluates strictly matching locally applied overrides preventing lag before reflecting real native states dynamically.
  ProblemTag get currentStatus => _currentStatus ?? widget.problem.tagName;

  /// Casts strict machine timestamps towards localized human interpretations visually cleanly.
  /// 
  /// Formats the provided [dateTime] into a Thai locale string including Buddhist year conversion.
  String _formatThaiDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year + 543; // แปลงเป็น พ.ศ.
    final time = DateFormat('HH:mm').format(dateTime);
    return '$day/$month/$year $time';
  }

  /// Evaluates mandatory upload contexts launching distinctly layered visual verification prompts whenever concluding events correctly.
  /// 
  /// Initiates a status change attempt to [newStatus]. If the status is [ProblemTag.completed], 
  /// it enforces an image upload via [_showPhotoUploadDialog] first.
  Future<void> _showStatusChangeDialog(ProblemTag newStatus) async {
    if (newStatus == ProblemTag.completed) {
      await _showPhotoUploadDialog();
    } else {
      _changeStatus(newStatus);
    }
  }

  /// Triggers internal device galleries extracting raw photographic binaries satisfying endpoint completion strictly natively.
  ///
  /// This operates asynchronously initiating deep architecture queries securely hooking local operating systems distinctly isolating failures gracefully.
  ///
  /// Side effects:
  /// Rewrites the active [_completedImage] formally saving binary endpoints locally preventing loss abruptly firing [setState] exactly.
  Future<void> _showPhotoUploadDialog() async {
    _tempImage = null;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PhotoUploadWidget(
                  onUploadPressed: () async {
                    try {
                      final XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 80,
                      );
                      if (image != null) {
                        setDialogState(() {
                          _tempImage = File(image.path);
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
                  },
                  onTakePhotoPressed: () async {
                    try {
                      final XFile? image = await _picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 80,
                      );
                      if (image != null) {
                        setDialogState(() {
                          _tempImage = File(image.path);
                        });
                      }
                    } catch (e) {
                      if (mounted) {
                        CustomSnackBar.showError(
                          context: context,
                          message: 'ถ่ายรูปไม่สำเร็จ',
                        );
                      }
                    }
                  },
                  selectedImage: _tempImage,
                ),
                if (_tempImage != null) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _completedImage = _tempImage;
                        });
                        Navigator.pop(context);
                        _changeStatus(ProblemTag.completed);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF5D3891),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Obliterates local configurations entirely flushing active problem sets explicitly cleanly towards cloud databases directly.
  ///
  /// This operates asynchronously initiating deep architecture queries securely hooking local operating systems distinctly isolating failures gracefully.
  /// 
  /// Asks for confirmation before deleting the current problem report via [ProblemProvider].
  Future<void> _deleteProblem() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => const DeleteConfirmationDialog(),
    );

    if (confirmed == true && mounted) {
      try {
        await context.read<ProblemProvider>().deleteProblem(
          problemId: widget.problem.id,
        );

         CustomSnackBar.showSuccess(
          context: context,
          message: 'ลบปัญหาเรียบร้อยแล้ว',
        );
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          CustomSnackBar.showError(
            context: context,
            message: 'ลบปัญหาไม่สำเร็จ',
          );
        }
      }
    }
  }

  /// Casts localized administrative intent backwards mutating universal item structures safely visually verifying correctly via prompts dynamically.
  ///
  /// Side effects:
  /// Rewrites the active [_currentStatus] internally temporarily applying graphical overrides abruptly firing [setState] exactly.
  /// 
  /// Updates the problem's tag to [newStatus] on the server.
  Future<void> _changeStatus(ProblemTag newStatus) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<ProblemProvider>().changeProblemTag(
        problemId: widget.problem.id,
        newTag: newStatus,
      );

      setState(() {
        _currentStatus = newStatus;
        _statusUpdatedAt = DateTime.now();
      });

      if (mounted) {
        CustomSnackBar.showSuccess(
          context: context,
          message: 'เปลี่ยนเป็น "${newStatus.labelTh}"',
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context: context,
          message: 'เปลี่ยนสถานะไม่สำเร็จ: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final isAdmin = authProvider.user?.isAdmin ?? false;
    final formattedDate = DateFormat(
      'dd/MM/yyyy HH:mm',
    ).format(widget.problem.createdAt.toLocal());

    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'รายละเอียดปัญหา',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF5D3891)),
          onPressed: _isLoading ? null : () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.problem.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: currentStatus.getStatusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: currentStatus.getStatusColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        currentStatus.labelTh,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: currentStatus.getStatusColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5D3891).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF5D3891).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.problem.typeName.labelTh,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5D3891),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_statusUpdatedAt != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'อัปเดตเมื่อ ${_formatThaiDate(_statusUpdatedAt!)} โดย Admin',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],

                const SizedBox(height: 16),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'แจ้งเมื่อ: $formattedDate',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.problem.locationName,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.map, size: 20, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          const Text(
                            'ตำแหน่งที่เกิดปัญหา',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ProblemLocationMap(
                        location: LatLng(
                          widget.problem.lat,
                          widget.problem.lng,
                        ),
                        title: widget.problem.title,
                        snippet: widget.problem.locationName,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 20,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'รายละเอียด',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.problem.detail,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.photo_library,
                            size: 20,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'ภาพประกอบ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (widget.problem.imageUrl != null &&
                          widget.problem.imageUrl!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.problem.imageUrl!,
                            width: double.infinity,
                            height: 280,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image_outlined,
                                        size: 60,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'ไม่สามารถโหลดรูปภาพได้',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 60,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'ไม่สามารถโหลดรูปภาพได้',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                if (_completedImage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 20,
                              color: Colors.green[700],
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'ภาพหลังแก้ไข',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (_statusUpdatedAt != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'อัปโหลดเมื่อ ${_formatThaiDate(_statusUpdatedAt!)} โดย Admin',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _completedImage!,
                            width: double.infinity,
                            height: 280,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                if (isAdmin) ...[
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5D3891).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF5D3891).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AdminStatusManagement(
                          currentStatus: currentStatus,
                          onStatusChange: _showStatusChangeDialog,
                          isLoading: _isLoading,
                        ),

                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: _isLoading ? null : _deleteProblem,
                          icon: const Icon(Icons.delete_outline, size: 20),
                          label: const Text('ลบปัญหานี้'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
