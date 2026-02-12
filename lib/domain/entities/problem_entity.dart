import 'package:cmu_fondue/domain/enum/problem_enums.dart';

class ProblemEntity {
  final String id;
  final String title;
  final String detail;
  final double lat;
  final double lng;
  final int upvoteCount;
  final DateTime createdAt;
  final String reporterEmail;
  final ProblemType typeName;
  final ProblemTag tagName;
  final String imageUrl;
  final String locationName;

  ProblemEntity({
    required this.id,
    required this.title,
    required this.detail,
    required this.lat,
    required this.lng,
    required this.upvoteCount,
    required this.createdAt,
    required this.reporterEmail,
    required this.typeName,
    required this.tagName,
    required this.imageUrl,
    required this.locationName,
  });

  factory ProblemEntity.fromGenerated(dynamic data) {
    return ProblemEntity(
      id: data.problemId,
      title: data.title,
      detail: data.detail,
      lat: data.problemLat.toDouble(),
      lng: data.problemLng.toDouble(),
      upvoteCount: data.upvoteCount,
      createdAt: data.createdAt.toDateTime(),
      reporterEmail: data.reporter.email,

      // แปลง String เป็น ProblemType
      typeName: ProblemType.values.firstWhere(
        (e) => e.name == data.problemType.typeName,
        orElse: () => ProblemType.other,
      ),

      // แปลง String เป็น ProblemTag (Status)
      // สมมติว่า data.currentTags.tagName คือ "pending", "inProgress" ฯลฯ
      tagName: ProblemTag.values.firstWhere(
        (e) => e.name == data.currentTags.tagName,
        orElse: () => ProblemTag.pending,
      ),

      locationName: data.locationName ?? '',
      imageUrl: data.imageUrl ?? '',
    );
  }
}
