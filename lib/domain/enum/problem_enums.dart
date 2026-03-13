/*
 * File: problem_enums.dart
 * Description: Enumerations defining the possible states and types of problems.
 * Responsibilities: Provides enumerations, hardcoded IDs, localized labels, and visual status colors for problems.
 * Author: Rachata 650510638
 * Course: CMU Fondue
 */

import 'dart:ui';

/// The current processing state of a problem report.
enum ProblemTag {
  /// The problem report is awaiting triage.
  pending,

  /// The problem has been acknowledged by administrators.
  received,

  /// Action is currently being taken on the problem.
  inProgress,

  /// The problem has been fully resolved.
  completed,
}

/// Extension methods for [ProblemTag] to provide associated data.
extension ProblemTagX on ProblemTag {
  /// The unique database identifier associated with this tag.
  String get tagId {
    switch (this) {
      case ProblemTag.received:
        return 'd74d3f00-e2fb-4b71-9d06-1f4b336c56b7';
      case ProblemTag.pending:
        return '519a08f6-ee74-4b2b-870e-b35c951c8ee8';
      case ProblemTag.inProgress:
        return '619a08f6-ee74-4b2b-870e-b35c951c8ef9';
      case ProblemTag.completed:
        return 'f306d165-b7f8-422e-b509-571eea11e99b';
    }
  }

  /// The Thai translation of this tag for display purposes.
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

  /// The standard UI color representing the status of this tag.
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

/// The categorization type indicating the nature of a problem report.
enum ProblemType {
  /// Problems relating to streets, traffic, or pavement.
  road,

  /// Problems involving power lines, lighting, or electrical hazards.
  electricity,

  /// Problems concerning plumbing, drainage, or water supply.
  water,

  /// Issues regarding waste management or litter.
  garbage,

  /// Any issue that does not fit into predefined categories.
  other,
}

/// Extension methods for [ProblemType] to provide associated data.
extension ProblemTypeX on ProblemType {
  /// The unique database identifier associated with this type.
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

  /// The Thai translation of this category for display purposes.
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
