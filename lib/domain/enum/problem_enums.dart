import 'dart:ui';

enum ProblemStatus { pending, received, inProgress, completed }

extension ProblemStatusX on ProblemStatus {
  String get labelTh {
    switch (this) {
      case ProblemStatus.pending:
        return 'รอรับเรื่อง';
      case ProblemStatus.received:
        return 'รับเรื่องแล้ว';
      case ProblemStatus.inProgress:
        return 'กำลังดำเนินการ';
      case ProblemStatus.completed:
        return 'เสร็จสิ้น';
    }
  }

  Color get getStatusColor {
    switch (this) {
      case ProblemStatus.pending:
        return const Color(0xFFE53935); // แดง
      case ProblemStatus.received:
        return const Color(0xFF5D3891); // ม่วง
      case ProblemStatus.inProgress:
        return const Color(0xFFFF8604); // ส้ม
      case ProblemStatus.completed:
        return const Color(0xFF2E7D32); // เขียว
    }
  }
}

enum ProblemType { road, electricity, water, garbage, other }

extension ProblemTypeX on ProblemType {
  String get labelTh {
    switch (this) {
      case ProblemType.road:
        return 'ถนน';
      case ProblemType.electricity:
        return 'ไฟฟ้า';
      case ProblemType.water:
        return 'น้ำ';
      case ProblemType.garbage:
        return 'ขยะ';
      case ProblemType.other:
        return 'อื่นๆ';
    }
  }
}
