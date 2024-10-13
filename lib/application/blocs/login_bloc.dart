import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';

// Eventos
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Estados
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Definição do BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUserUseCase;

  LoginBloc({required this.loginUserUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const LoginFailure('Email and password are required'));
      emit(LoginInitial());
      return;
    }

    emit(LoginLoading());

    try {
      final user = await loginUserUseCase(event.email, event.password);

      if (user != null) {
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
}
