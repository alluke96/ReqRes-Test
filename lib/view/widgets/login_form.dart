import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres_test/blocs/login/login_bloc.dart';
import 'package:reqres_test/blocs/login/login_events.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void submit() {
      context.read<LoginBloc>().add(LoginButtonPressed(email: _emailController.text.trim().toLowerCase(), password: _passwordController.text.trim()));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const Text("Login", style: TextStyle(color: Color.fromRGBO(78, 79, 39, 1), fontWeight: FontWeight.bold, fontSize: 30)),
          
          const SizedBox(height: 30),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: const Color.fromARGB(75, 194, 198, 135)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(196, 135, 198, .3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ]
            ),
            child: Column(
              children: <Widget>[
          
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color.fromRGBO(197, 198, 135, 0.298)))
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.grey.shade700)
                    ),
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onSubmitted: (value) => submit(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey.shade700)
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: TextButton(onPressed: () {}, 
              child: const Text("Forgot the password?", style: TextStyle(color: Color.fromRGBO(198, 192, 135, 1)))
            )
          ),

          const SizedBox(height: 30),

          MaterialButton(
            onPressed: () => submit(),
            color: Colors.yellow,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            height: 50,
            child: const Center(
              child: Text("Login", style: TextStyle(color: Colors.black)),
            ),
          ),

        ],
      ),
    );
  }
}
