import 'dart:ui';

enum ProblemTag { pending, received, inProgress, completed }

extension ProblemTagX on ProblemTag {
  String get labelTh {
    switch (this) {
      case ProblemTag.pending:
        return 'รอดำเนินการ';
      case ProblemTag.received:
        return 'รับเรื่องแล้ว';
      case ProblemTag.inProgress:
        return 'กำลังดำเนินการ';
      case ProblemTag.completed:
        return 'เสร็จสิ้น';
    }
  }

  Color get getStatusColor {
    switch (this) {
      case ProblemTag.pending:
        return const Color(0xFFE53935); // แดง
      case ProblemTag.received:
        return const Color(0xFF5D3891); // ม่วง
      case ProblemTag.inProgress:
        return const Color(0xFFFF8604); // ส้ม
      case ProblemTag.completed:
        return const Color(0xFF2E7D32); // เขียว
    }
  }
}

enum ProblemType { road, electricity, water, garbage, other }

extension ProblemTypeX on ProblemType {
  String get labelTh {
    switch (this) {
      case ProblemType.road:
        return 'ถนน/ทางเท้า';
      case ProblemType.electricity:
        return 'ไฟฟ้า/แสงสว่าง';
      case ProblemType.water:
        return 'น้ำ';
      case ProblemType.garbage:
        return 'ขยะ';
      case ProblemType.other:
        return 'อื่นๆ';
    }
  }
}
