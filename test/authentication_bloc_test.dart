import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reqres_test/application/blocs/login/login_bloc.dart';
import 'package:reqres_test/data/repositories/user_repository.dart';

// Criando mocks usando o Mockito
class MockUserRepository extends Mock implements UserRepository {}

void main() async {
  late LoginBloc LoginBloc;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    LoginBloc = LoginBloc();
    LoginBloc.init("https://reqres.in/api"); // Para não precisar dar load no .env
  });

  tearDown(() {
    LoginBloc.close();
  });

  group('LoginBloc', () {
    test('Deve emitir LoginSuccess quando o login for bem-sucedido', () async {
      // Arrange
      const email = 'eve.holt@reqres.in';
      const password = '1234';
      const token = 'QpwL5tke4Pnpja7X4';
      
      when(mockUserRepository.login(email, password)).thenAnswer((_) async => 'token_de_exemplo');

      // Assert
      final expectedStates = [
        LoginInitial(),
        LoginLoading(),
        const LoginSuccess(token),
      ];

      expectLater(
        LoginBloc.stream,
        emitsInOrder(expectedStates),
      );

      // Act
      LoginBloc.add(const LoginButtonPressed(email: email, password: password));
    });

    test('Deve emitir LoginFailure quando o email ou senha estiverem vazios', () async {
      // Arrange
      const email = '';
      const password = '';
      
      // Assert
      final expectedStates = [
        LoginInitial(),
        const LoginFailure('Email and password are required'),
        LoginInitial(),
      ];

      expectLater(
        LoginBloc.stream,
        emitsInOrder(expectedStates),
      );

      // Act
      LoginBloc.add(const LoginButtonPressed(email: email, password: password));
    });

    test('Deve emitir LoginFailure quando o login falhar', () async {
      // Arrange
      const email = 'wrong@email.com';
      const password = '1234';

      when(mockUserRepository.login(email, password)).thenAnswer((_) async => null);

      // Assert
      final expectedStates = [
        LoginInitial(),
        LoginLoading(),
        const LoginFailure('Login failed'),
        LoginInitial(),
      ];

      expectLater(
        LoginBloc.stream,
        emitsInOrder(expectedStates),
      );

      // Act
      LoginBloc.add(const LoginButtonPressed(email: email, password: password));
    });
  });
}
