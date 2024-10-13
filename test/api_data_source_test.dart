import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:reqres_test/data/data_sources/user_api_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([http.Client]) // Adiciona anotação para gerar mocks
void main() {
  late MockHttpClient mockHttpClient;
  late ApiDataSource apiDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiDataSource = ApiDataSource(mockHttpClient, baseUrl: 'https://reqres.in/api');
  });

  group('Login API Test', () {
    test('Deve retornar token ao realizar login com sucesso', () async {
      // Arrange
      when(mockHttpClient.post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: anyNamed('body'),
      )).thenAnswer((_) async {
        print('Mock post called');
        return http.Response('{"token": "QpwL5tke4Pnpja7X4"}', 200);
      });
      // Act
      final result = await apiDataSource.login('eve.holt@reqres.in', '1234');

      // // Assert
      expect(result['token'], 'QpwL5tke4Pnpja7X4');
    });

    // test('Deve lançar uma exceção com mensagem adequada ao falhar no login digitando apenas a senha', () async {
    //   // Arrange
    //   when(mockHttpClient.post(
    //     Uri.parse('https://reqres.in/api/login'),
    //     headers: anyNamed('headers'),
    //     body: anyNamed('body'),
    //   )).thenAnswer((_) async => http.Response('{"error":"Missing email or username"}', 400));

    //   // Act
    //   expect(() async => await apiDataSource.login('', 'wrongpassword'), throwsA(isA<Exception>()));
    // });
  });
}
