import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:reqres_test/data/data_sources/api_data_source.dart';

// Cria uma classe MockHttpClient
class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([http.Client]) // Adiciona anotação para gerar mocks
void main() {
  late ApiDataSource apiDataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiDataSource = ApiDataSource(mockHttpClient);
  });

  test('Deve lançar uma exceção ao falhar no login', () async {
    when(mockHttpClient.post(
      Uri.parse('https://reqres.in/api/login'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response('{"error": "Invalid credentials"}', 400));

    expect(
      () async => await apiDataSource.login('wrong.email@example.com', 'wrongpassword'),
      throwsA(isA<Exception>()),
    );
  });
}
