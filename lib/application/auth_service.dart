import 'package:flutter/foundation.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';
import 'package:reqres_test/domain/use_cases/logout_user.dart';

class AuthService with ChangeNotifier {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  AuthService(this.loginUser, this.logoutUser);

  Future<User?> login(String email, String password) async {
    return await loginUser.call(email, password);
  }

  Future<void> logout() async {
    return await logoutUser.call();
  }
}
