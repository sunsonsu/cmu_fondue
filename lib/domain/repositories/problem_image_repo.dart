import 'package:cmu_fondue/domain/entities/problem_image_entity.dart';

// Komsan
abstract class ProblemImageRepo {

  // Get a problem image by problemID
  Future<List<ProblemImageEntity>> getProblemImageByProblemId(String problemId);

  //Create a new problemImage
  Future<String> createProblemImage({
      required String problemId,
      required String imageUrl,
      required String fileName,
      required String imageType,
  });

  //Update an existing problemImage
  Future<void> updateProblemImage({
    required String problemImageId,
    required String problemId,
    String? imageUrl,
    String? fileName,
    String? imageType,
  });

  //Delete a problemImage
  Future<void> deleteProblemImage(String problemImageId);
}
