import 'package:logger/logger.dart';
import 'package:reqres_test/data/data_sources/api_data_source.dart';
import 'package:reqres_test/domain/models/user.dart';

class UserRepository {
  final ApiDataSource apiDataSource;

  UserRepository(this.apiDataSource);

  Future<User?> login(String email, String password) async {
    final response = await apiDataSource.login(email, password);
    if (response.isEmpty) {
      Logger().e('Login failed');
      return null;
    }
    
    final users = await apiDataSource.getUsers();

    // Find user in users list
    User? foundUser;
    for (final u in users) {
      if (u.email == email) {
        foundUser = u;
        break;
      }
    }

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
