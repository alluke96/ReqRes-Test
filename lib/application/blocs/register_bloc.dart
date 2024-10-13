import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/domain/use_cases/register_user.dart';

// Eventos
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  const RegisterButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Estados
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;

  const RegisterSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}

// BLoC para Registro
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUserUseCase;

  RegisterBloc({required this.registerUserUseCase}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const RegisterFailure('Email and password are required'));
      emit(RegisterInitial());
      return;
    }

    emit(RegisterLoading());

    try {
      final user = await registerUserUseCase(event.email, event.password);

      if (user != null) {
        emit(RegisterSuccess(user));
      } else {
        emit(const RegisterFailure('Registration failed'));
        emit(RegisterInitial());
      }
    } catch (error) {
      emit(RegisterFailure(error.toString()));
      emit(RegisterInitial());
    }
  }
}
