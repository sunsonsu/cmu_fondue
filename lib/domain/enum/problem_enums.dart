import 'dart:ui';

enum ProblemTag { pending, received, inProgress, completed }

extension ProblemTagX on ProblemTag {
  String get tagId {
    switch (this) {
      case ProblemTag.pending:
        return '519a08f6-ee74-4b2b-870e-b35c951c8ee8';
      case ProblemTag.received:
        return 'd74d3f00-e2fb-4b71-9d06-1f4b336c56b7';
      case ProblemTag.inProgress:
        return '619a08f6-ee74-4b2b-870e-b35c951c8ef9';
      case ProblemTag.completed:
        return 'f306d165-b7f8-422e-b509-571eea11e99b';
    }
  }

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
        return const Color(0xFF1976D2); // น้ำเงิน
      case ProblemTag.inProgress:
        return const Color(0xFFFF8604); // ส้ม
      case ProblemTag.completed:
        return const Color(0xFF2E7D32); // เขียว
    }
  }
}

enum ProblemType { road, electricity, water, garbage, other }

extension ProblemTypeX on ProblemType {
  String get typeId {
    switch (this) {
      case ProblemType.road:
        return '44444444-5555-6666-7777-888888888888';
      case ProblemType.electricity:
        return '33333333-4444-5555-6666-777777777777';
      case ProblemType.water:
        return '11111111-2222-3333-4444-555555555555';
      case ProblemType.garbage:
        return '22222222-3333-4444-5555-666666666666';
      case ProblemType.other:
        return 'd5f1c828-39c2-4145-93c4-bb4ccea3da62';
    }
  }

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
