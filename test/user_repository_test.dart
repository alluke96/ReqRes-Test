import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_test/blocs/login/login_bloc.dart';
import 'package:reqres_test/blocs/login/login_events.dart';
import 'package:reqres_test/blocs/login/login_states.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      loginBloc = LoginBloc()..init;
    });

    blocTest(
      'inicializa o LoginBloc vazio',
       build: () => loginBloc,
       expect: () => [],
    );

    blocTest(
      'emite erro ao fazer login quando o email e a senha estiverem vazios', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: '', password: '')),
      expect: () => [
        const LoginFailure('Email and password are required'), 
        LoginInitial()
      ],
    );

    blocTest(
      'emite erro ao fazer login quando o email for invalido', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: 'invalid-email', password: 'password')),
      expect: () => [
        const LoginFailure('Please enter a valid email'), 
        LoginInitial()
      ],
    );

    blocTest(
      'emite LoginFailure quando o login falhar devido a usuario nao encontrado', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: 'invalid@email.com', password: 'invalid-password')),
      wait: const Duration(seconds: 1),
      expect: () => [
        LoginLoading(), 
        const LoginFailure('Exception: Login failed: user not found'), 
        LoginInitial()
      ],
    );

  });
}