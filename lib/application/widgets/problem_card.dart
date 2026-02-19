import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_status_tag.dart';
import 'package:cmu_fondue/application/widgets/problem_category_tag.dart';

class ProblemCard extends StatefulWidget {
  final ProblemEntity problem;

  const ProblemCard({super.key, required this.problem});

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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProblemDetailPage(problem: widget.problem),
          ),
        );
      },
      child: Container(
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
                child: Image.network(
                  widget.problem.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.problem.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

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
                        'แจ้งเมื่อ: ${{widget.problem.createdAt}}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.problem.locationName,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Tags
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
                            color: isUpvoted ? activeColor : Colors.transparent,
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
    );
  }
}
