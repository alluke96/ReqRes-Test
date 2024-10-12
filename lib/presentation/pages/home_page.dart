import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:reqres_test/application/auth_service.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.logout();
      
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } catch (e) {
      Logger().e(e.toString());
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

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
