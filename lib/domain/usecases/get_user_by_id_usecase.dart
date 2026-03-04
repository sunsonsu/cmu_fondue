import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

// Komsan
class GetUserByIdUseCase {
  final UserRepo repository;

  GetUserByIdUseCase(this.repository);

  Future<UserEntity?> call(String userId) async {
    return await repository.getUserById(userId);
  }
}
