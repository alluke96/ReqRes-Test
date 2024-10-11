import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/user.dart';

class ApiDataSource {
  final String baseUrl = 'https://reqres.in/api';
  final http.Client httpClient;

  ApiDataSource(this.httpClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao logar: ${response.body}');
    }
  }

  Future<User?> getUser(int id) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return User.fromJson(data);
    } else {
      throw Exception('Falha ao buscar usuário: ${response.body}');
    }
  }
}
