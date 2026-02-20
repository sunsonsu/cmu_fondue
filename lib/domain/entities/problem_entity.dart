import 'package:cmu_fondue/domain/enum/problem_enums.dart';

// Komsan
class ProblemEntity {
  final String id;
  final String title;
  final String detail;
  final double lat;
  final double lng;
  int upvoteCount;
  final DateTime createdAt;
  final String reporterEmail;
  final ProblemType typeName;
  final ProblemTag tagName;
  final String locationName;
  final bool isUpvotedByMe;
  final String? imageUrl;

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
    required this.locationName,
    required this.isUpvotedByMe,
    this.imageUrl,
  });

  factory ProblemEntity.fromGenerated(dynamic data) {
    String? firstImageUrl;
    if (data.problemImages_on_problem != null &&
        data.problemImages_on_problem.isNotEmpty) {
      firstImageUrl = data.problemImages_on_problem[0].imageUrl;
    }

    final bool upvotedByMe =
        data.userUpvotes_on_problem != null &&
        data.userUpvotes_on_problem.isNotEmpty;

    return ProblemEntity(
      id: data.problemId,
      title: data.title,
      detail: data.detail,
      lat: data.problemLat.toDouble(),
      lng: data.problemLng.toDouble(),

      upvoteCount: data.upvoteCount,

      createdAt: data.createdAt.toDateTime(),
      reporterEmail: data.reporter.email,

      typeName: ProblemType.values.firstWhere(
        (e) => e.labelTh == data.problemType.typeThaiName,
        orElse: () => ProblemType.other,
      ),

      tagName: ProblemTag.values.firstWhere(
        (e) => e.labelTh == data.currentTags.tagThaiName,
        orElse: () => ProblemTag.pending,
      ),

      locationName: data.locationName,
      imageUrl: firstImageUrl,
      isUpvotedByMe: upvotedByMe,
    );
  }
}
