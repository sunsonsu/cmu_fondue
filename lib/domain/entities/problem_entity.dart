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
  final String reporterId;
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
    required this.reporterId,
    required this.typeName,
    required this.tagName,
    required this.locationName,
    required this.isUpvotedByMe,
    this.imageUrl,
  });

  factory ProblemEntity.fromGenerated(dynamic data, String? currentUserId) {
    String? firstImageUrl;
    if (data.problemImages_on_problem != null &&
        data.problemImages_on_problem.isNotEmpty) {
      firstImageUrl = data.problemImages_on_problem[0].imageUrl;
    }

    final bool upvotedByMe =
        currentUserId != null &&
        data.userUpvotes_on_problem != null &&
        data.userUpvotes_on_problem.any(
          (upvote) => upvote.userId == currentUserId,
        );

    return ProblemEntity(
      id: data.problemId,
      title: data.title,
      detail: data.detail,
      lat: data.problemLat.toDouble(),
      lng: data.problemLng.toDouble(),

      upvoteCount: data.upvoteCount,

      createdAt: data.createdAt.toDateTime(),
      reporterEmail: data.reporter.email,
      reporterId: data.reporter.userId,


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

  ProblemEntity copyWith({
    String? id,
    String? title,
    String? detail,
    double? lat,
    double? lng,
    int? upvoteCount,
    DateTime? createdAt,
    String? reporterEmail,
    String? reporterId,
    ProblemType? typeName,
    ProblemTag? tagName,
    String? locationName,
    String? imageUrl,
    bool? isUpvotedByMe,
  }) {
    return ProblemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      upvoteCount: upvoteCount ?? this.upvoteCount,
      createdAt: createdAt ?? this.createdAt,
      reporterEmail: reporterEmail ?? this.reporterEmail,
      reporterId: reporterId ?? this.reporterId,
      typeName: typeName ?? this.typeName,
      tagName: tagName ?? this.tagName,
      locationName: locationName ?? this.locationName,
      imageUrl: imageUrl ?? this.imageUrl,
      isUpvotedByMe: isUpvotedByMe ?? this.isUpvotedByMe,
    );
  }
}
