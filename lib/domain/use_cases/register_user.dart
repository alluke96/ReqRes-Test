import 'package:reqres_test/data/repositories/user_repository.dart';
import 'package:reqres_test/domain/models/user.dart';

class RegisterUser {
  final UserRepository userRepository;

  RegisterUser(this.userRepository);

  Future<User?> call(String email, String password) async {
    return await userRepository.register(email, password);
  }
}
