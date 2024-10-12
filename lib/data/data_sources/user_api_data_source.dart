import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_test/domain/models/user.dart';

class ApiDataSource {
  final String baseUrl;
  final http.Client httpClient;

  ApiDataSource(this.httpClient, {String? baseUrl}): baseUrl = baseUrl ?? dotenv.get('API_URL');

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Login failed: $error');
    }
  }

  Future<List<User>> getUsers() async {
    final response = await httpClient.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<User>.from(data.map((user) => User.fromJson(user)));
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to fetch users: $error');
    }
  }

  Future<User?> getUser(int id) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return User.fromJson(data);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to fetch user: $error');
    }
  }

  Future<void> logout() async {
    final response = await httpClient.post(Uri.parse('$baseUrl/logout'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data;
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to logout: $error');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Registration failed: $error');
    }
  }
}
