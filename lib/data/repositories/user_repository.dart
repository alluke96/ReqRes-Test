import 'package:logger/logger.dart';
import 'package:reqres_test/data/data_sources/user_api_data_source.dart';
import 'package:reqres_test/domain/models/user.dart';

class UserRepository {
  final ApiDataSource apiDataSource;

  UserRepository(this.apiDataSource);

  Future<String?> login(String email, String password) async {
    final response = await apiDataSource.login(email, password);
    if (response.isEmpty) {
      Logger().e('Login failed');
      return null;
    }

    final String token = response['token'];
    return token;
  }

  Future<User?> getUser(String email) async {
    final users = await apiDataSource.getUsers();

    // Encontra o usuário com o e-mail informado
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
