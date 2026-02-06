import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Invalid credentials');
    }

    return repository.login(email, password);
  }
}
