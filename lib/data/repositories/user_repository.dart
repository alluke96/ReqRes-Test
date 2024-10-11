import 'dart:developer';

import '../data_sources/api_data_source.dart';
import '../../domain/models/user.dart';

class UserRepository {
  final ApiDataSource apiDataSource;

  UserRepository(this.apiDataSource);

  Future<User?> login(String email, String password) async {
    final response = await apiDataSource.login(email, password);
    inspect(response);
    return await apiDataSource.getUser(2); // Exemplo com ID fixo
  }
}
