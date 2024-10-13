import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reqres_test/application/blocs/login/login_bloc.dart';
import 'package:reqres_test/application/blocs/login/login_states.dart';
import 'package:reqres_test/presentation/pages/home_page.dart';
import 'package:reqres_test/presentation/widgets/login_header.dart';
import 'package:reqres_test/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const LoginHeader(),

            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  Fluttertoast.showToast(
                    msg: state.error,
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.red,
                    webBgColor: 'linear-gradient(to right, #FF0000, #FF0000)',
                    textColor: Colors.white,
                  );
                }
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user: state.user)));
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Column(
                      children: [
                        Text('Logging in...', style: TextStyle(color: Color.fromRGBO(78, 79, 39, 1), fontWeight: FontWeight.bold, fontSize: 30)),
                        
                        SizedBox(height: 30),

                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      const LoginForm(),

                      const SizedBox(height: 20),

                      Center(child: TextButton(onPressed: () {}, child: const Text("Create an account", style: TextStyle(color: Color.fromRGBO(79, 76, 39, 0.6))))),
                    ],
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
