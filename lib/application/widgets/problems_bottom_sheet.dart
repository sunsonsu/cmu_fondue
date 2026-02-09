import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';

class ProblemsBottomSheet extends StatefulWidget {
  const ProblemsBottomSheet({super.key});

  @override
  State<ProblemsBottomSheet> createState() => _ProblemsBottomSheetState();
}

class _ProblemsBottomSheetState extends State<ProblemsBottomSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: 0.4,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      snap: true,
      snapSizes: const [0.25, 0.4, 0.85],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Fixed Drag Handle & Header
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  // Allow dragging from header area
                  final currentSize = _controller.size;
                  final delta =
                      -details.primaryDelta! /
                      MediaQuery.of(context).size.height;
                  final newSize = (currentSize + delta).clamp(0.25, 0.85);
                  _controller.jumpTo(newSize);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      // Drag Handle
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Header
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ปัญหาที่เคยถูกแจ้งบริเวณนี้',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Scrollable Problems List
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10,
                  itemBuilder: (context, index) => _buildProblemCard(index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProblemCard(int index) {
    final problems = [
      {
        'title': 'ถนนแตกหน้าหอสมุด',
        'status': 'ยังไม่ได้แก้ไข',
        'type': 'ถนน',
        'imageUrl':
            'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=200&h=200&fit=crop',
        'reportedDate': '15/01/2567',
        'location': 'หน้าอาคารหอสมุด มช.',
        'description':
            'ถนนมีรอยแตกขนาดใหญ่ ความยาวประมาณ 2 เมตร อาจเกิดอันตรายต่อการสัญจร',
      },
      {
        'title': 'ไฟฟ้าขัดข้อง',
        'status': 'กำลังแก้ไข',
        'type': 'ไฟฟ้า',
        'imageUrl':
            'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=200&h=200&fit=crop',
        'reportedDate': '18/01/2567',
        'location': 'อาคารวิศวกรรม ชั้น 3',
        'description': 'ไฟส่องสว่างดับหมดทั้งชั้น ส่งผลกระทบต่อการเรียนการสอน',
      },
      {
        'title': 'ท่อน้ำแตก',
        'status': 'ยังไม่ได้แก้ไข',
        'type': 'ขยะ',
        'imageUrl':
            'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=200&h=200&fit=crop',
        'reportedDate': '20/01/2567',
        'location': 'หลังอาคารวิทยาศาสตร์',
        'description':
            'ท่อน้ำแตกทำให้น้ำไหลออกมาอย่างต่อเนื่อง อาจทำให้เกิดน้ำท่วมขัง',
      },
      {
        'title': 'ทางเท้าชำรุด',
        'status': 'เสร็จสิ้น',
        'type': 'ถนน',
        'imageUrl':
            'https://images.unsplash.com/photo-1599481238640-191a4c52e5b2?w=200&h=200&fit=crop',
        'reportedDate': '10/01/2567',
        'location': 'ทางเข้าคณะพาณิชย์',
        'description':
            'ทางเท้าแตกเป็นแผ่นสร้างความไม่สะดวกในการเดิน ได้รับการซ่อมแซมเรียบร้อยแล้ว',
      },
      {
        'title': 'ต้นไม้ล้ม',
        'status': 'กำลังแก้ไข',
        'type': 'อื่นๆ',
        'imageUrl':
            'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=200&h=200&fit=crop',
        'reportedDate': '22/01/2567',
        'location': 'สวนหย่อมหน้าคณะมนุษย์',
        'description':
            'ต้นไม้ใหญ่ล้มขวางทางเดิน จำเป็นต้องตัดและเคลื่อนย้ายออก',
      },
      {
        'title': 'ป้ายจราจรชำรุด',
        'status': 'รับเรื่องแล้ว',
        'type': 'อื่นๆ',
        'imageUrl':
            'https://images.unsplash.com/photo-1449253984488-e5b74f37809f?w=200&h=200&fit=crop',
        'reportedDate': '19/01/2567',
        'location': 'สี่แยกหน้าประตู 1',
        'description': 'ป้ายจราจรล้มเอียง ไม่สามารถมองเห็นสัญลักษณ์ได้ชัดเจน',
      },
      {
        'title': 'ถังขยะเต็ม',
        'status': 'เสร็จสิ้น',
        'type': 'อื่นๆ',
        'imageUrl':
            'https://images.unsplash.com/photo-1526951521990-620dc14c214b?w=200&h=200&fit=crop',
        'reportedDate': '12/01/2567',
        'location': 'ลานจอดรถ คณะศึกษาศาสตร์',
        'description':
            'ถังขยะเต็มล้นจนขยะเกลื่อนพื้น ได้รับการเก็บและทำความสะอาดแล้ว',
      },
      {
        'title': 'รั้วชำรุด',
        'status': 'กำลังแก้ไข',
        'type': 'อื่นๆ',
        'imageUrl':
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200&h=200&fit=crop',
        'reportedDate': '21/01/2567',
        'location': 'ข้างสนามกีฬา',
        'description':
            'รั้วกั้นหักเสียหายยาวหลายเมตร อาจเกิดอันตรายแก่นักศึกษา',
      },
      {
        'title': 'ไฟถนนไม่ติด',
        'status': 'ยังไม่ได้แก้ไข',
        'type': 'ไฟฟ้า',
        'imageUrl':
            'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=200&h=200&fit=crop',
        'reportedDate': '23/01/2567',
        'location': 'ถนนหลังหอพัก',
        'description': 'ไฟถนนไม่ติดหลายจุดทำให้กลางคืนมืดมากเกินไป ไม่ปลอดภัย',
      },
      {
        'title': 'หลุมบนถนน',
        'status': 'ยังไม่ได้แก้ไข',
        'type': 'ถนน',
        'imageUrl':
            'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=200&h=200&fit=crop',
        'reportedDate': '24/01/2567',
        'location': 'ถนนเข้าอาคารเรียนรวม',
        'description': 'หลุมลึกเป็นอันตรายต่อรถจักรยานยนต์และรถยนต์ที่ผ่านไปมา',
      },
    ];

    final problem = problems[index % problems.length];

    return ProblemCard(
      title: problem['title'] as String,
      status: problem['status'] as String,
      type: problem['type'] as String,
      imageUrl: problem['imageUrl'] as String,
      reportedDate: problem['reportedDate'] as String,
      location: problem['location'] as String,
      description: problem['description'] as String,
    );
  }
}
