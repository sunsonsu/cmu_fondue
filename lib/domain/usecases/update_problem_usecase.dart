/*
 * File: update_problem_usecase.dart
 * Description: Use case for altering the metadata attributes of an existing problem.
 * Responsibilities: Forwards field replacements down to the problem datastore.
 * Author: Komsan 650510601
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

/// Supplies a targeted conduit for modifying problem record schemas incrementally.
class UpdateProblemUseCase {
  /// The destination repository owning the records.
  final ProblemRepo repository;

  /// Initializes a new instance of [UpdateProblemUseCase].
  UpdateProblemUseCase(this.repository);

  /// Pushes any submitted field modifications directly against an [id].
  ///
  /// This operates asynchronously. Only fields specifically supplied overriding null will overwrite existing remote entries.
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
