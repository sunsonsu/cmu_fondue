import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_status_tag.dart';
import 'package:cmu_fondue/application/widgets/problem_category_tag.dart';

class ProblemCard extends StatelessWidget {
  final ProblemEntity problem;

  const ProblemCard({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ใช้ MaterialPageRoute เพื่อเปิดหน้าใหม่แบบ Full Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProblemDetailPage(problem: problem),
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
                  problem.imageUrl,
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
                  // Title
                  Text(
                    problem.title,
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
                        'แจ้งเมื่อ: ${{problem.createdAt}}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
                          problem.locationName,
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
                      ProblemStatusTag(status: problem.tagName),
                      ProblemCategoryTag(category: problem.typeName),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    problem.detail,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
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
