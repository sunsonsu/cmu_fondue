import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/application/widgets/problem_status_tag.dart';
import 'package:cmu_fondue/application/widgets/problem_category_tag.dart';
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
  final Color activeColor = const Color(0xFF6750A4);
  late int localUpvoteCount;
  late bool isUpvoted;

  @override
  void initState() {
    super.initState();
    isUpvoted = widget.problem.isUpvotedByMe;
    localUpvoteCount = widget.problem.upvoteCount;
  }

  @override
  void didUpdateWidget(covariant ProblemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ถ้าข้อมูล ID เดียวกันแต่ค่า upvote หรือสถานะเปลี่ยน ให้ update local state ตาม
    if (widget.problem.upvoteCount != oldWidget.problem.upvoteCount ||
        widget.problem.isUpvotedByMe != oldWidget.problem.isUpvotedByMe) {
      setState(() {
        isUpvoted = widget.problem.isUpvotedByMe;
        localUpvoteCount = widget.problem.upvoteCount;
      });
    }
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
                            onTap: () => handleUpvote(),
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'ต้องการลบรายงานปัญหานี้หรือไม่ ?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'หากยืนยัน จะไม่สามารถกู้คืนรายงานนี้ได้',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(dialogContext).pop();
                      await _deleteProblem(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'ยืนยัน',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  'ลบปัญหาสำเร็จ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.fromLTRB(80, 50, 20, 0),
            width: 280,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'เกิดข้อผิดพลาด: $e',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.fromLTRB(80, 50, 20, 0),
            width: 300,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  Future<void> handleUpvote() async {
    final previousIsUpvoted = isUpvoted;
    final previousCount = localUpvoteCount;

    final problemProvider = context.read<ProblemProvider>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      isUpvoted = !isUpvoted;
      localUpvoteCount += isUpvoted ? 1 : -1;
    });

    try {
      await problemProvider.toggleUpvote(
        problemId: widget.problem.id,
        isUpvoted: isUpvoted,
      );

      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isUpvoted = previousIsUpvoted;
        localUpvoteCount = previousCount;
      });

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Failed to update upvote. Please try again.'),
        ),
      );
    }
  }
}
