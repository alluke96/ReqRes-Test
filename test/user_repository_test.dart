import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reqres_test/application/blocs/login/login_bloc.dart';
import 'package:reqres_test/application/blocs/login/login_events.dart';
import 'package:reqres_test/application/blocs/login/login_states.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_test/data/repositories/user_repository.dart';
import 'package:reqres_test/domain/models/user.dart';

class MockUserRepository extends Mock implements UserRepository {}

// Gerando mocks para o Client HTTP
@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('Login', () {
    const user = User(
      id: 2,
      email: 'janet.weaver@reqres.in',
      firstName: 'Janet',
      lastName: 'Weaver',
      avatar: 'https://reqres.in/img/faces/2-image.jpg',
    );

    final mockUserRepository = MockUserRepository();
    // Mockando o comportamento do login no repositório
    when(mockUserRepository.login('janet.weaver@reqres.in', 'cityslicka'))
      .thenAnswer((_) async => Future.value('12345'));
        
    blocTest<LoginBloc, LoginState>(
      'realiza login com sucesso',
      build: () {
        return LoginBloc();
      },
      act: (bloc) => bloc.add(const LoginButtonPressed(
        email: 'janet.weaver@reqres.in', 
        password: 'cityslicka',
      )),
      expect: () => <LoginState>[
        LoginLoading(),
        const LoginSuccess(user),
      ],
    );
  });
}
