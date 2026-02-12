import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProblemDetailPage extends StatelessWidget {
  final ProblemEntity problem;

  const ProblemDetailPage({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd/MM/yyyy HH:mm',
    ).format(problem.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดปัญหา'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ชื่อปัญหา ---
            Text(
              problem.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // --- วันที่แจ้ง ---
            Text(
              'แจ้งเมื่อ: $formattedDate',
              style: const TextStyle(fontSize: 16, color: Color(0xff696969)),
            ),
            // --- สถานะ ---
            Text(
              problem.tagName.labelTh,
              style: TextStyle(fontSize: 16, color: problem.tagName.getStatusColor),
            ),
            // --- สถานที่ ---
            RichText(
              text: TextSpan(
                text: '${problem.locationName} ',
                style: const TextStyle(color: Color(0xff696969), fontSize: 16),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: ใส่ Logic เปิด Google Maps
                        print("Open Map");
                      },
                      child: const Text(
                        'ดูแผนที่',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          color: Color(0xff696969),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // --- รายละเอียด ---
            Text(
              problem.detail,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 8),
            const Text(
              "ภาพประกอบ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // --- รูปภาพ ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                problem.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
