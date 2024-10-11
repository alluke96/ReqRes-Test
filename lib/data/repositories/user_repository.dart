import 'package:logger/logger.dart';
import 'package:reqres_test/data/data_sources/api_data_source.dart';
import 'package:reqres_test/domain/models/user.dart';

class UserRepository {
  final ApiDataSource apiDataSource;

  UserRepository(this.apiDataSource);

  Future<User?> login(String email, String password) async {
    final token = await apiDataSource.login(email, password);
    Logger().i(token);
    final user = await apiDataSource.getUsers();
    Logger().i(user);

    // Find user in user list
    User? foundUser;
    for (final u in user) {
      if (u.email == email || u.username == email) {
        foundUser = u;
        break;
      }
    }
    Logger().i(foundUser);

    if (foundUser == null) {
      Logger().e('User not found');
      return null;
    }

    return await apiDataSource.getUser(foundUser.id);
  }

  Future<void> logout() async {
    return await apiDataSource.logout();
  }
}
