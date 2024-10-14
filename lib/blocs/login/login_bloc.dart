import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres_test/blocs/login/login_events.dart';
import 'package:reqres_test/blocs/login/login_states.dart';
import 'package:reqres_test/data/repositories/user_repository.dart';
import 'package:reqres_test/data/data_sources/user_api_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late ApiDataSource apiDataSource;
  UserRepository userRepository = UserRepository(ApiDataSource());

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void init() {
    apiDataSource = ApiDataSource();
    userRepository = UserRepository(apiDataSource);
  }

  Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (event.email.isNotEmpty && !event.email.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
      emit(const LoginFailure('Please enter a valid email'));
      emit(LoginInitial());
      return;
    }

    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const LoginFailure('Email and password are required'));
      emit(LoginInitial());
      return;
    }

    emit(LoginLoading());

    try {
      final token = await userRepository.login(event.email, event.password);

      if (token != null) {
        // Pega o usuário baseado no e-mail, afinal na API do ReqRes só retorna um token (nem é JWT)
        final user = await userRepository.getUser(event.email);

        if (user == null) {
          emit(const LoginFailure('User not found'));
          emit(LoginInitial());
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token); // Armazena para uso futuro

        emit(LoginSuccess(user));
      } else {
        emit(const LoginFailure('Login failed'));
        emit(LoginInitial());
      }
    } catch (error) {
      emit(LoginFailure(error.toString()));
      emit(LoginInitial());
    }
  }

  Future<void> _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<LoginState> emit) async {
    await userRepository.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    emit(LoginInitial());
  }
}