import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

class UpdateProblemUseCase {
  final ProblemRepo repository;

  UpdateProblemUseCase(this.repository);

  Future<void> call({
    required String id,
    required String title,
    required String detail,
    required String locationName,
    required double lat,
    required double lng,
    required String typeId,
    required String tagId,
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
