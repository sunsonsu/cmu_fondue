import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call(
    String email,
    String password,
    String confirmPassword,
  ) {
    if (password != confirmPassword) {
      throw Exception('Password does not match');
    }

    return repository.register(email, password);
  }
}

