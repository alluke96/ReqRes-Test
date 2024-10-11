import 'package:flutter/material.dart';
import 'package:reqres_test/domain/models/user.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo, ${user.first_name} ${user.last_name}!'),
            const SizedBox(height: 20),
            Image.network(user.avatar),
          ],
        ),
      ),
    );
  }
}
