import 'package:reqres_test/data/repositories/user_repository.dart';

class LoginUser {
  final UserRepository userRepository;

  LoginUser(this.userRepository);

  Future<String?> call(String email, String password) async {
    return await userRepository.login(email, password);
  }
}
