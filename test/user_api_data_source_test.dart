import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reqres_test/application/blocs/login/login_bloc.dart';
import 'package:reqres_test/application/blocs/login/login_events.dart';
import 'package:reqres_test/application/blocs/login/login_states.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_test/data/data_sources/user_api_data_source.dart';
import 'package:reqres_test/domain/models/user.dart';

class MockApiDataSource extends Mock implements ApiDataSource {}

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

    final mockApiDataSource = MockApiDataSource();
    // Mockando o comportamento do login no repositório
    when(mockApiDataSource.login('janet.weaver@reqres.in', 'cityslicka'))
      .thenAnswer((_) async => {'token': '12345'}); // Retorna um token simulado ao logar com sucesso
        
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
