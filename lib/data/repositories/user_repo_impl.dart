import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/entities/user_entity.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final ConnectorConnector connector;

  UserRepoImpl({required this.connector});

  @override
  Future<void> updateFcmToken(String userId, String token) async {
    await connector.updateFcmToken(userId: userId, fcmToken: token).execute();
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    try {
      final result = await connector.getUserById(userId: userId).execute();
      if (result.data.user == null) {
        return null;
      }
      return UserEntity.fromGenerated(result.data.user);
    } catch (e) {
      throw Exception("ไม่สามารถดึงข้อมูล user ได้: $e");
    }
  }
}