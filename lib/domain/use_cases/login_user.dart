import 'package:reqres_test/data/repositories/user_repository.dart';
import 'package:reqres_test/domain/models/user.dart';

class LoginUser {
  final UserRepository userRepository;

  LoginUser(this.userRepository);

  Future<User?> call(String email, String password) async {
    return await userRepository.login(email, password);
  }
}
