/*
 * File: firebase_auth_data_source.dart
 * Description: Direct integration layer interfacing with the Firebase Auth SDK.
 * Responsibilities: Performs explicit API calls for login, registration, and logout utilizing Firebase credentials.
 * Author: Rachata 650510638
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Wraps the Firebase Authentication SDK providing specialized domain exceptions.
class FirebaseAuthDataSource {
  /// The underlying Firebase authentication client instance.
  final FirebaseAuth _firebaseAuth;

  /// Initializes a new instance of [FirebaseAuthDataSource].
  FirebaseAuthDataSource(this._firebaseAuth);

  /// Retrieves the currently cached authentication profile, or null if unauthenticated.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Submits an authentication request using the provided [email] and [password].
  ///
  /// This operates asynchronously over the network.
  /// Throws domain-specific exceptions like [InvalidCredentialsException] or [InvalidEmailException] based on standard Firebase error codes.
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

  /// Attempts to register a brand new identity using [email] and [password].
  ///
  /// This operates asynchronously over the network.
  /// Throws domain exceptions like [EmailAlreadyInUseException] mapped from Firebase errors.
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

  /// Establishes a listener stream reacting to identity session changes (login/logout events).
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  /// Revokes the current active session token overriding any cached identity.
  ///
  /// Side effects:
  /// Broadly terminates the local authentication context emitting a null identity downstream.
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
