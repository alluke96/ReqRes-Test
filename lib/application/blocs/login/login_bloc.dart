import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres_test/application/blocs/login/login_events.dart';
import 'package:reqres_test/application/blocs/login/login_states.dart';
import 'package:reqres_test/data/repositories/user_repository.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';
import 'package:reqres_test/data/data_sources/user_api_data_source.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late ApiDataSource apiDataSource;
  late UserRepository userRepository;
  late LoginUser loginUserUseCase;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void init(String baseUrl) {
    final httpClient = http.Client();
    apiDataSource = ApiDataSource(httpClient, baseUrl);
    userRepository = UserRepository(apiDataSource);
    loginUserUseCase = LoginUser(userRepository);
  }

  Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const LoginFailure('Email and password are required'));
      emit(LoginInitial());
      return;
    }

    emit(LoginLoading());

    try {
      final token = await loginUserUseCase(event.email, event.password);

      if (token != null) {
        // Pega o usuário baseado no e-mail, afinal na API do ReqRes só retorna um token (nem é JWT)
        final user = await userRepository.getUser(event.email);

        emit(LoginSuccess(user!));
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
    emit(LoginInitial());
  }
}