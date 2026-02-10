import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/application/pages/create_report_page.dart';

class AssignedProblemsPage extends StatelessWidget {
  final String location;

  const AssignedProblemsPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    // Mock data - ปัญหาที่เคยถูกแจ้ง
    final mockProblems = [
      {
        'title': 'แอร์ห้องเรียน 301 เสีย ร้อนมาก',
        'status': 'รับเรื่องแล้ว',
        'type': 'ไฟฟ้า',
        'reportedDate': '20/01/2568',
        'location': location,
        'description':
            'แอร์ในห้องเรียน 301 อาคาร Computer Science เสียมา 2 สัปดาห์แล้ว นักศึกษาเรียนลำบากมาก ร้อนจนไม่สามารถเรียนได้',
        'imageUrl':
            'https://images.unsplash.com/photo-1631545775396-496e0b152bd6?w=400',
      },
      {
        'title': 'ห้องน้ำชั้น 2 ท่อน้ำรั่ว น้ำขังเยอะ',
        'status': 'กำลังแก้ไข',
        'type': 'อื่นๆ',
        'reportedDate': '18/01/2568',
        'location': location,
        'description':
            'ห้องน้ำหญิงชั้น 2 มีน้ำรั่วจากท่อ ทำให้พื้นเปียกลื่นตลอดเวลา อาจเสี่ยงต่อการลื่นล้ม',
        'imageUrl':
            'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400',
      },
      {
        'title': 'ไฟฟ้าดับบ่อยในห้อง Lab คอมพิวเตอร์',
        'status': 'ยังไม่ได้แก้ไข',
        'type': 'ไฟฟ้า',
        'reportedDate': '15/01/2568',
        'location': location,
        'description':
            'ไฟฟ้าในห้อง Lab 401 ดับบ่อยครั้ง โดยเฉพาะช่วงบ่าย ทำให้การเรียนการสอนไม่ต่อเนื่อง',
        'imageUrl':
            'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=400',
      },
      {
        'title': 'ประตูทางเข้าอาคารชำรุด ปิดไม่สนิท',
        'status': 'รับเรื่องแล้ว',
        'type': 'อื่นๆ',
        'reportedDate': '12/01/2568',
        'location': location,
        'description':
            'ประตูกระจกทางเข้าด้านหน้าอาคารชำรุด ปิดไม่สนิท ทำให้ฝนสาดเข้ามาในอาคาร',
        'imageUrl':
            'https://images.unsplash.com/photo-1519666213631-80f8c5ca84d3?w=400',
      },
      {
        'title': 'แอร์ไม่ติดบ่อย และมีเสียงดังผิดปกติ',
        'status': 'กำลังแก้ไข',
        'type': 'อื่นๆ',
        'reportedDate': '10/01/2568',
        'location': location,
        'description':
            'แอร์อาคาร Computer Science ไม่ติดบ่อยครั้ง และมีเสียงดังผิดปกติ อาจเสี่ยงอันตราย',
        'imageUrl':
            'https://images.unsplash.com/photo-1600543992453-e0a2b4a66e71?w=400',
      },
      {
        'title': 'โต๊ะเก้าอี้ในห้องเรียน 201 ชำรุดหลายตัว',
        'status': 'รับเรื่องแล้ว',
        'type': 'อื่นๆ',
        'reportedDate': '08/01/2568',
        'location': location,
        'description':
            'เก้าอี้ในห้องเรียน 201 หักและโยกงายหลายตัว ไม่สามารถนั่งได้ ควรเปลี่ยนใหม่',
        'imageUrl':
            'https://images.unsplash.com/photo-1503428593586-e225b39bddfe?w=400',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ปัญหาที่เคยถูกแจ้งบริเวณนี้',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'ตรวจสอบว่าปัญหาที่คุณต้องการแจ้ง มีคนแจ้งแล้วหรือยัง ถ้ามีการแจ้งแล้วสามารถกด Upvote ได้ แต่ถ้ายังสามารถกดแจ้งปัญหาได้',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),

          // Location Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Problems List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: mockProblems.length,
              itemBuilder: (context, index) {
                final problem = mockProblems[index];
                return ProblemCard(
                  title: problem['title'] as String,
                  status: problem['status'] as String,
                  type: problem['type'] as String,
                  reportedDate: problem['reportedDate'] as String,
                  location: problem['location'] as String,
                  description: problem['description'] as String,
                  imageUrl: problem['imageUrl'],
                );
              },
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Report Problem Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreateReportPage(location: location),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF5D3891),
                      ),
                      child: const Text(
                        'แจ้งปัญหา',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: Color(0xFF5D3891),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5D3891),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
