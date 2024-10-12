import 'package:flutter/foundation.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';
import 'package:reqres_test/domain/use_cases/logout_user.dart';
import 'package:reqres_test/domain/use_cases/register_user.dart';

class AuthService with ChangeNotifier {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final RegisterUser registerUser;

  AuthService(this.loginUser, this.logoutUser, this.registerUser);

  Future<User?> login(String email, String password) async {
    return await loginUser.call(email, password);
  }

  Future<void> logout() async {
    return await logoutUser.call();
  }

  Future<User?> register(String email, String password) async {
    return await registerUser.call(email, password);
  }
}
