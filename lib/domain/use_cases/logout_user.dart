
import 'package:reqres_test/data/repositories/user_repository.dart';

class LogoutUser {
  final UserRepository userRepository;

  LogoutUser(this.userRepository);

  Future<void> call() async {
    return await userRepository.logout();
  }
}
