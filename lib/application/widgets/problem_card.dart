import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/application/widgets/problem_status_tag.dart';
import 'package:cmu_fondue/application/widgets/problem_category_tag.dart';
import 'package:cmu_fondue/application/widgets/delete_confirmation_dialog.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/domain/repositories/problem_repo.dart';
import 'package:cmu_fondue/data/repositories/problem_repo_impl.dart';
import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProblemCard extends StatefulWidget {
  final ProblemEntity problem;
  final VoidCallback? onDeleted;

  const ProblemCard({super.key, required this.problem, this.onDeleted});

  @override
  State<ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  // สร้างสถานะภายใน Widget เพื่อใช้ในการ Toggle สี
  bool isUpvoted = false;
  final Color activeColor = const Color(0xFF6750A4);
  late int localUpvoteCount; // สร้างตัวแปรใหม่ไว้ที่นี่

  @override
  void initState() {
    super.initState();
    // ดึงค่าเริ่มต้นมาจาก Entity
    localUpvoteCount = widget.problem.upvoteCount;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final isAdmin = authProvider.user?.isAdmin ?? false;
    final formattedDate = DateFormat(
      'dd/MM/yyyy HH:mm',
    ).format(widget.problem.createdAt);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProblemDetailPage(problem: widget.problem),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        (widget.problem.imageUrl != null &&
                            widget.problem.imageUrl!.isNotEmpty)
                        ? Image.network(
                            widget.problem.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          )
                        : const Icon(
                            Icons.image_not_supported,
                          ), // แสดง icon ถ้าไม่มี URL
                  ),
                ),

                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.problem.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Date and Location
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'แจ้งเมื่อ: $formattedDate',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.problem.locationName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Status and Category Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          ProblemStatusTag(status: widget.problem.tagName),
                          ProblemCategoryTag(category: widget.problem.typeName),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        widget.problem.detail,
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      // Upvote Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          // เพิ่ม Material เพื่อให้ InkWell แสดง Ripple Effect บน Container
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isUpvoted = !isUpvoted;
                                // แก้ไขค่าใน Entity (หมายเหตุ: ในแอปจริงควรจัดการผ่าน Repository/Provider)
                                localUpvoteCount += isUpvoted ? 1 : -1;
                              });
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isUpvoted
                                    ? activeColor
                                    : Colors.transparent,
                                border: Border.all(color: activeColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isUpvoted
                                                ? Icons.thumb_up_alt
                                                : Icons.thumb_up_alt_outlined,
                                            size: 16,
                                            color: isUpvoted
                                                ? Colors.white
                                                : activeColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Upvote',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isUpvoted
                                                  ? Colors.white
                                                  : activeColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: isUpvoted
                                          ? Colors.white.withOpacity(0.5)
                                          : activeColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        '$localUpvoteCount',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isUpvoted
                                              ? Colors.white
                                              : activeColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isAdmin)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => _showDeleteConfirmation(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.black54,
                    size: 24,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => const DeleteConfirmationDialog(),
    );

    if (confirmed == true && mounted) {
      await _deleteProblem(context);
    }
  }

  Future<void> _deleteProblem(BuildContext context) async {
    try {
      // แสดง loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // ลบปัญหา
      final ProblemRepo repo = ProblemRepoImpl(
        connector: ConnectorConnector.instance,
      );
      await repo.deleteProblem(widget.problem.id);

      // ปิด loading
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // แสดง SnackBar แจ้งผลลัพธ์
      if (context.mounted) {
        CustomSnackBar.showSuccess(
          context: context,
          message: 'ลบปัญหาสำเร็จ',
        );
      }

      // เรียก callback เพื่อให้ parent refresh ข้อมูล
      widget.onDeleted?.call();
    } catch (e) {
      // ปิด loading
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // แสดงข้อความ error
      if (context.mounted) {
        CustomSnackBar.showError(
          context: context,
          message: 'ลบปัญหาไม่สำเร็จ',
        );
      }
    }
  }
}
