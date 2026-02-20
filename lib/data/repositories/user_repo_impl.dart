import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final ConnectorConnector connector;

  UserRepoImpl({required this.connector});

  @override
  Future<void> updateFcmToken(String userId, String token) async {
    await connector.updateFcmToken(userId: userId, fcmToken: token).execute();
  }
}