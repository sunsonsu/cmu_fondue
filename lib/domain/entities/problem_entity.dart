
import 'package:cmu_fondue/domain/enum/problem_enums.dart';

class ProblemEntity {
  final String id;
  final String title;
  final ProblemStatus status;
  final ProblemType type;
  final String imageUrl;
  final DateTime reportedAt;
  final String location;
  final String description;

  const ProblemEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.type,
    required this.imageUrl,
    required this.reportedAt,
    required this.location,
    required this.description,
  });
}
