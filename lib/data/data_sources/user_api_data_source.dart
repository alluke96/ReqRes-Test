import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reqres_test/models/user.dart';

class ApiDataSource {
  String baseUrl = 'https://reqres.in/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
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
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return List<User>.from(data.map((user) => User.fromJson(user)));
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to fetch users: $error');
    }
  }

  Future<User?> getUser(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return User.fromJson(data);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to fetch user: $error');
    }
  }

  Future<void> logout() async {
    final response = await http.post(Uri.parse('$baseUrl/logout'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data;
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to logout: $error');
    }
  }

}
