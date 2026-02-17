import '../repositories/problem_repo.dart';

// Komsan
class CreateProblemUseCase {
  final ProblemRepo repository;

  CreateProblemUseCase(this.repository);

  Future<String> call({
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String reporterId,
    required String typeId,
    required String tagId,
  }) async {
    return await repository.createProblem(
      title: title,
      detail: detail,
      locationName: locationName,
      lat: lat,
      lng: lng,
      reporterId: reporterId,
      typeId: typeId,
      tagId: tagId,
    );
  }
}
