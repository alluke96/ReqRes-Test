import 'package:flutter/material.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
            Text('Welcome, ${widget.user.firstName} ${widget.user.lastName}!'),

            const SizedBox(height: 20),

            Image.network(widget.user.avatar),

            const SizedBox(height: 20),
            
            ElevatedButton(onPressed: () => _logout(), child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
