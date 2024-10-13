import 'package:flutter/material.dart';
import 'package:reqres_test/presentation/widgets/login_header.dart';
import 'package:reqres_test/presentation/widgets/login_form.dart';
import 'package:reqres_test/presentation/widgets/register_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const LoginHeader(),
            // AnimatedSwitcher para transições suaves
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),  // Duração da animação
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Fade + slide
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },     // Mostra o LoginForm
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: isRegistering
                ? const RegisterForm()
                : const LoginForm(),
            ),
            
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isRegistering = !isRegistering; // Alterna entre login/registro
                  });
                },
                child: Text(isRegistering ? "Already have an account?" : "Create an account", style: const TextStyle(color: Color.fromRGBO(79, 76, 39, 0.6)),
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
