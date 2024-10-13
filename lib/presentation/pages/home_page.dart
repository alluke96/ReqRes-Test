import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqres_test/application/blocs/login/login_bloc.dart';
import 'package:reqres_test/application/blocs/login/login_events.dart';
import 'package:reqres_test/application/blocs/login/login_states.dart';
import 'package:reqres_test/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            final user = state.user;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${user.firstName} ${user.lastName}!'),

                  const SizedBox(height: 20),

                  Image.network(user.avatar),

                  const SizedBox(height: 20),
                  
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          } else if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Please log in.'));
          }
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    context.read<LoginBloc>().add(LogoutButtonPressed());

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
