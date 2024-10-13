import 'package:reqres_test/domain/use_cases/login_user.dart';
import 'package:reqres_test/domain/use_cases/logout_user.dart';

class AuthenticationService {
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  AuthenticationService(this.loginUser, this.logoutUser);

  Future<void> login(String email, String password) async {
    await loginUser.call(email, password);
  }

  Future<void> logout() async {
    await logoutUser.call();
  }
}
