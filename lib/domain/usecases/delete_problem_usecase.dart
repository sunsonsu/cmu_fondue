/*
 * File: delete_problem_usecase.dart
 * Description: Use case for entirely removing a problem report.
 * Responsibilities: Instructs the repository to permanently delete a problem.
 * Author: Komsan
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import '../repositories/problem_repo.dart';
  
/// Executes the business logic required to delete an existing problem.
class DeleteProblemUseCase {
  /// The dependent repository handling problem records.
  final ProblemRepo repository;

  /// Initializes a new instance of [DeleteProblemUseCase].
  DeleteProblemUseCase(this.repository);
  
  /// Commands the deletion of the problem matching [id].
  ///
  /// This operates asynchronously.
  Future<void> call(String id) async {
    return await repository.deleteProblem(id);
  }
}