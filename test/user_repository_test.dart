import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_test/blocs/login/login_bloc.dart';
import 'package:reqres_test/blocs/login/login_events.dart';
import 'package:reqres_test/blocs/login/login_states.dart';
import 'package:reqres_test/models/user.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      loginBloc = LoginBloc()..init;
    });

    blocTest(
      'emite que inicializa vazio',
       build: () => loginBloc,
       expect: () => [],
    );

    blocTest(
      'emite erro quando o email e a senha estiverem vazios', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: '', password: '')),
      expect: () => [
        const LoginFailure('Email and password are required'), 
        LoginInitial()
      ],
    );

    blocTest(
      'emite erro quando o email for invalido', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: 'invalid-email', password: 'password')),
      expect: () => [
        const LoginFailure('Please enter a valid email'), 
        LoginInitial()
      ],
    );

    blocTest(
      'emite erro quando o login falhar', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: 'invalid@email.com', password: 'invalid-password')),
      expect: () => [
        LoginLoading(), 
        const LoginFailure('Login failed'), 
        LoginInitial()
      ],
    );

    blocTest(
      'emite token quando o login for bem-sucedido', 
      build: () => loginBloc,
      act: (bloc) => loginBloc.add(const LoginButtonPressed(email: 'george.bluth@reqres.in', password: 'cityslicka')),
      expect: () => [
        LoginLoading(),
        const LoginSuccess(User(id: 1, email: 'george.bluth@reqres.in', firstName: 'George', lastName: 'Bluth', avatar: 'https://reqres.in/img/faces/1-image.png')),
        LoginInitial(),
      ],
    );
  });
}