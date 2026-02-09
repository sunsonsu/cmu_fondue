import 'package:flutter/material.dart';

class ProblemStatusTag extends StatelessWidget {
  final String status;

  const ProblemStatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: statusColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13,
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ยังไม่ได้แก้ไข':
        return const Color(0xFFE53935); // แดง
      case 'รับเรื่องแล้ว':
        return const Color(0xFF5D3891); // ม่วง
      case 'กำลังแก้ไข':
        return const Color(0xFFFF8604); // ส้ม
      case 'เสร็จสิ้น':
        return const Color(0xFF2E7D32); // เขียว
      default:
        return Colors.white;
    }
  }
}
