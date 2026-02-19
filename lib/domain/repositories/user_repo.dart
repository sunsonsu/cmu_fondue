abstract class UserRepo {
  Future<void> updateFcmToken(String userId, String token);
}