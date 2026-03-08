import 'package:flutter/material.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';

class AdminStatusManagement extends StatelessWidget {
  final ProblemTag currentStatus;
  final Function(ProblemTag) onStatusChange;
  final bool isLoading;

  const AdminStatusManagement({
    super.key,
    required this.currentStatus,
    required this.onStatusChange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.admin_panel_settings,
              color: const Color(0xFF5D3891),
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'จัดการสถานะ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D3891),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // แสดงปุ่มตามสถานะปัจจุบัน
        if (currentStatus == ProblemTag.pending) ...[
          // ยังไม่ได้แก้ไข -> รับเรื่อง
          ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () => onStatusChange(ProblemTag.received),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.check_circle_outline, size: 20),
            label: const Text('รับเรื่อง'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[400],
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ] else if (currentStatus == ProblemTag.received) ...[
          // รับเรื่อง -> กำลังแก้ไข (primary)
          ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () => onStatusChange(ProblemTag.inProgress),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.build_circle_outlined, size: 20),
            label: const Text('เริ่มดำเนินการแก้ไข'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8604),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[400],
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // ย้อนกลับเป็นยังไม่ได้แก้ไข (secondary)
          OutlinedButton.icon(
            onPressed: isLoading
                ? null
                : () => onStatusChange(ProblemTag.pending),
            icon: const Icon(Icons.undo, size: 18),
            label: const Text('ยังไม่ได้แก้ไข'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey[700],
              side: BorderSide(color: Colors.grey[400]!),
              disabledForegroundColor: Colors.grey[400],
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ] else if (currentStatus == ProblemTag.inProgress) ...[
          // กำลังแก้ไข -> เสร็จสิ้น (primary)
          ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () => onStatusChange(ProblemTag.completed),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.check_circle, size: 20),
            label: const Text('ทำเครื่องหมายเสร็จสิ้น'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[400],
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // ตัวเลือกรอง
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => onStatusChange(ProblemTag.received),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('รับเรื่อง'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[400]!),
                    disabledForegroundColor: Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => onStatusChange(ProblemTag.pending),
                  icon: const Icon(Icons.cancel_outlined, size: 18),
                  label: const Text('ยังไม่ได้แก้ไข'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE53935),
                    disabledForegroundColor: Colors.grey[400],
                    side: BorderSide(
                      color: isLoading
                          ? Colors.grey[400]!
                          : const Color(0xFFE53935),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ] else if (currentStatus == ProblemTag.completed) ...[
          // เสร็จสิ้นแล้ว - ไม่สามารถเปลี่ยนได้
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: Colors.green[700], size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'เรื่องนี้เสร็จสิ้นแล้ว',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ไม่สามารถเปลี่ยนแปลงสถานะได้อีก',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
