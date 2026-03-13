/*
 * File: problem_entity.dart
 * Description: Entity representing a reported problem.
 * Responsibilities: Encapsulates all data related to a problem report and provides methods for parsing from generated SDK data and copying instances.
 * Author: Komsan 650510601 & Rachata 650510638
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/enum/problem_enums.dart';

/// Represents a problem reported by a user in the system.
class ProblemEntity {
  /// The unique identifier of the problem.
  final String id;

  /// The unique identifier of the user who reported the problem.
  final String reporterId;

  /// The brief title summarizing the problem.
  final String title;

  /// The full detailed description of the problem.
  final String detail;

  /// The latitude coordinate where the problem occurred.
  final double lat;

  /// The longitude coordinate where the problem occurred.
  final double lng;

  /// The number of upvotes this problem has received.
  int upvoteCount;

  /// The date and time when the problem was reported.
  final DateTime createdAt;

  /// The email address of the user who reported the problem.
  final String reporterEmail;

  /// The categorization type of the problem.
  final ProblemType typeName;

  /// The current tag classifying the state of the problem.
  final ProblemTag tagName;

  /// The named location where the problem occurred.
  final String locationName;

  /// Whether the currently authenticated user has upvoted this problem.
  final bool isUpvotedByMe;

  /// The URL of the primary image associated with this problem, or null if no image exists.
  final String? imageUrl;

  /// Initializes a new instance of [ProblemEntity].
  ProblemEntity({
    required this.id,
    required this.reporterId,
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

  /// Constructs an entity from dynamic generated data, integrating the active user status.
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
      reporterId: data.reporterId,
      title: data.title,
      detail: data.detail,
      lat: data.problemLat.toDouble(),
      lng: data.problemLng.toDouble(),

      upvoteCount: data.userUpvotes_on_problem?.length ?? 0,

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

  /// Creates a new copy of the [ProblemEntity] with specified properties replaced.
  ProblemEntity copyWith({
    String? id,
    String? reporterId,
    String? title,
    String? detail,
    double? lat,
    double? lng,
    int? upvoteCount,
    DateTime? createdAt,
    String? reporterEmail,
    ProblemType? typeName,
    ProblemTag? tagName,
    String? locationName,
    String? imageUrl,
    bool? isUpvotedByMe,
  }) {
    return ProblemEntity(
      id: id ?? this.id,
      reporterId: reporterId ?? this.reporterId,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      upvoteCount: upvoteCount ?? this.upvoteCount,
      createdAt: createdAt ?? this.createdAt,
      reporterEmail: reporterEmail ?? this.reporterEmail,
      typeName: typeName ?? this.typeName,
      tagName: tagName ?? this.tagName,
      locationName: locationName ?? this.locationName,
      imageUrl: imageUrl ?? this.imageUrl,
      isUpvotedByMe: isUpvotedByMe ?? this.isUpvotedByMe,
    );
  }
}
