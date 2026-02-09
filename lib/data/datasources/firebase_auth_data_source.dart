import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<User> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw const InvalidCredentialsException();

        case 'invalid-email':
          throw const InvalidEmailException();

        default:
          throw const UnknownAuthException();
      }
    }
  }

  Future<User> register(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw const InvalidCredentialsException();

        case 'invalid-email':
          throw const InvalidEmailException();

        case 'email-already-in-use':
          throw const EmailAlreadyInUseException();

        default:
          throw const UnknownAuthException();
      }
    }
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
