import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

// Komsan
class UpdateProblemUseCase {
  final ProblemRepo repository;

  UpdateProblemUseCase(this.repository);

  Future<void> call({
    required String id,
    String? title,
    String? detail,
    String? locationName,
    double? lat,
    double? lng,
    String? typeId,
    String? tagId,
  }) async {
    return await repository.updateProblem(
      id: id,
      title: title,
      detail: detail,
      locationName: locationName,
      lat: lat,
      lng: lng,
      typeId: typeId,
      tagId: tagId,
    );
  }
}
