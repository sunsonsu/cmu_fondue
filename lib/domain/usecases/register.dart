import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call(
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      throw const PasswordNotMatchException();
    }

    if (!isValidPassword(password)) {
      throw const WeakPasswordException();
    }

    return repository.register(email, password);
  }

  bool isValidPassword(String password) {
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);

    return hasUpper && hasLower && hasDigit && password.length >= 8;
  }
}
