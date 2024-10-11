import '../models/user.dart';
import '../../data/repositories/user_repository.dart';

class LoginUser {
  final UserRepository userRepository;

  LoginUser(this.userRepository);

  Future<User?> call(String email, String password) async {
    return await userRepository.login(email, password);
  }
}
