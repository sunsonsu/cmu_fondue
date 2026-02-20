import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

/// Use case for updating the upvote status of a problem.
///
/// This use case encapsulates the logic for adding or removing an upvote.
/// It relies on the [ProblemRepository] to perform the actual data operations,
/// ensuring the [UserUpvote] entity and [Problem.upvoteCount] are kept in sync.
class UpdateProblemUpvoteUseCase {
  final ProblemRepo _problemRepository;

  UpdateProblemUpvoteUseCase(this._problemRepository);

  /// Executes the upvote update.
  ///
  /// [problemId]: The unique identifier of the problem.
  /// [isUpvote]: True to add an upvote, False to remove it.
  Future<void> call({required String problemId, required bool isUpvoted}) {
    if (isUpvoted) {
      return _problemRepository.addUpvote(id: problemId);
    } else {
      return _problemRepository.removeUpvote(id: problemId);
    }
  }
}