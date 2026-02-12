class ProblemEntity {
  final String id;
  final String title;
  final String detail;
  final double lat;
  final double lng;
  final int upvoteCount;
  final DateTime createdAt;
  final String reporterEmail;
  final String typeName;
  final String tagName;

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
      typeName: data.problemType.typeName,
      tagName: data.currentTags.tagName,
    );
  }
}