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
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            final user = state.user;

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome, ${user.firstName} ${user.lastName}!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Image.network(user.avatar),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () => _logout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                const Center(child: Text('Please log in')),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Login'),
                )
              ],
            );
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
