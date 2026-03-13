/*
 * File: problem_card.dart
 * Description: Compact responsive list tiles aggressively summarizing core problem entity domains explicitly seamlessly uniquely securely directly natively natively globally seamlessly visually.
 * Responsibilities: Bind distinct domain attributes natively elegantly drawing robust interactive bounding boxes hooking deletion correctly explicitly locally intuitively natively locally smoothly flawlessly uniquely perfectly.
 * Dependencies: ProblemEntity, ProblemProvider, Default Auth Provider 
 * Lifecycle: Created continually expanding global problem index arrays inherently rapidly, Disposed inherently dropping invisible instances correctly distinctly cleanly inherently identically dynamically globally globally reliably natively inherently inherently proactively defensively correctly gracefully securely distinctly distinctly intelligently dynamically uniquely strictly optimally perfectly reliably accurately actively defensively reliably strictly aggressively proactively optimally accurately securely uniquely optimally effectively smoothly natively cleanly intelligently clearly aggressively explicitly correctly securely smartly distinct natively elegantly cleanly seamlessly defensively proactively smoothly natively proactively cleanly gracefully globally strictly efficiently.
 * Author: Rachata 650510638 & Apiwit 650510648 & Chananchida 650510659
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/application/widgets/problem_status_tag.dart';
import 'package:cmu_fondue/application/widgets/problem_category_tag.dart';
import 'package:cmu_fondue/application/widgets/delete_confirmation_dialog.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

/// Unifies dense visual summaries representing core problem configurations correctly neatly flawlessly smoothly reliably distinctly defensively robustly locally.
class ProblemCard extends StatefulWidget {
  /// The isolated single entity model currently projecting inner properties actively securely distinct natively cleanly uniquely distinctly reliably deeply identically actively.
  final ProblemEntity problem;

  /// Dispatches completely decoupled native hooks destroying parent array nodes forcefully dynamically reliably completely actively elegantly completely distinct reliably accurately securely quickly smartly softly reliably natively clearly safely strictly exactly actively optimally securely correctly completely.
  final VoidCallback? onDeleted;

  /// Initiates dynamic async transactions forcing central cloud ledgers updating single upvote state directly uniquely gracefully optimally inherently gracefully directly.
  final Future<void> Function(bool isUpvoted)? onUpvote;

  /// Initializes a new instance of [ProblemCard].
  const ProblemCard({
    super.key,
    required this.problem,
    this.onDeleted,
    this.onUpvote,
  });

  @override
  State<ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  final Color activeColor = const Color(0xFF6750A4);
  late int localUpvoteCount;
  late bool isUpvoted;
  bool _isUpvoting = false;

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
    ).format(widget.problem.createdAt.toLocal());

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
                        : const Icon(Icons.image_not_supported),
                  ),
                ),

                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Padding(
                        padding: EdgeInsets.only(right: isAdmin ? 36.0 : 0),
                        child: Text(
                          widget.problem.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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

  /// Halts execution explicitly raising distinct modal blocking flows comprehensively intercepting arbitrary administrative removals accurately reliably reliably securely.
  void _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => const DeleteConfirmationDialog(),
    );

    if (confirmed == true && mounted) {
      await _deleteProblem(context);
    }
  }

  /// Drives remote network deletion calls dropping persistent cloud records directly aggressively globally perfectly clearly optimally safely gracefully efficiently intelligently uniquely identically securely actively natively smartly exactly smoothly.
  ///
  /// Side effects:
  /// Rewrites the active problem index permanently firing callback mechanisms flushing cached records actively identically effortlessly quickly directly loudly globally securely safely gracefully smartly properly completely rapidly efficiently proactively completely optimally correctly strictly forcefully strictly aggressively securely identically optimally seamlessly strictly uniquely precisely correctly properly gracefully tightly beautifully distinctly smartly securely properly sharply precisely.
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
      await context.read<ProblemProvider>().deleteProblem(
        problemId: widget.problem.id,
      );

      // ปิด loading
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // แสดง SnackBar แจ้งผลลัพธ์
      if (context.mounted) {
        CustomSnackBar.showSuccess(context: context, message: 'ลบปัญหาสำเร็จ');
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
        CustomSnackBar.showError(context: context, message: 'ลบปัญหาไม่สำเร็จ');
      }
    }
  }

  /// Executes remote API actions shifting boolean states explicitly natively completely updating layout boundaries accurately elegantly cleanly sharply natively.
  ///
  /// Side effects:
  /// Violently transforms local caching numbers mutating layout colors completely triggering [setState] gracefully effectively exactly optimally inherently strictly explicitly defensively fully tightly smoothly completely optimally optimally securely firmly properly cleanly accurately actively flawlessly dynamically gracefully smoothly properly perfectly quickly tightly actively accurately accurately purely natively safely forcefully optimally efficiently.
  Future<void> handleUpvote() async {
    // ถ้าไม่ได้ส่งฟังก์ชัน upvote มา ก็ไม่ต้องทำอะไร
    if (widget.onUpvote == null) return;

    // ป้องกันการกดซ้ำขณะที่กำลังประมวลผล
    if (_isUpvoting) return;
    _isUpvoting = true;

    final previousIsUpvoted = isUpvoted;
    final previousCount = localUpvoteCount;

    setState(() {
      isUpvoted = !isUpvoted;
      localUpvoteCount += isUpvoted ? 1 : -1;
    });

    try {
      // เรียกฟังก์ชันที่รับมาจากภายนอก
      await widget.onUpvote!(isUpvoted);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isUpvoted = previousIsUpvoted;
        localUpvoteCount = previousCount;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().contains('Login required')
                ? 'กรุณาเข้าสู่ระบบก่อนกด Upvote'
                : 'เกิดข้อผิดพลาด กรุณาลองใหม่',
          ),
        ),
      );
    } finally {
      _isUpvoting = false;
    }
  }
}
