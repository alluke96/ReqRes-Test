import 'package:flutter/foundation.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';

class AuthService with ChangeNotifier {
  final LoginUser loginUser;

  AuthService(this.loginUser);

  Future<User?> login(String email, String password) async {
    return await loginUser.call(email, password);
  }
}
