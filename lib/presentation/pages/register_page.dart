import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:reqres_test/application/auth_service.dart';
import 'package:reqres_test/domain/models/user.dart';
import 'package:reqres_test/presentation/pages/login_page.dart';
import 'package:reqres_test/presentation/widgets/login_header';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _register() async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        throw Exception('Please enter e-mail and password');
      }

      final authService = Provider.of<AuthService>(context, listen: false);
      User? user = await authService.register(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null && mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
      }
    } catch (e) {
      Logger().e(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        webBgColor: 'linear-gradient(to right, #FF0000, #FF0000)',
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginHeader(), // Usando o mesmo widget LoginHeader
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  FadeInUp(
                    duration: const Duration(milliseconds: 1500), 
                      child: const Text("Register", style: TextStyle(color: Color.fromRGBO(78, 79, 39, 1), fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  ),
                  
                  const SizedBox(height: 30),

                    FadeInUp(duration: const Duration(milliseconds: 1700), 
                      child: Container(
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey.shade700)
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),

                    const SizedBox(height: 30),

                    FadeInUp(
                      duration: const Duration(milliseconds: 1900), 
                      child: MaterialButton(
                        onPressed: () => _isLoading ? null : _register(),
                        color: const Color.fromARGB(255, 180, 175, 30),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        height: 50,
                        child: Center(
                          child: _isLoading 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white)) 
                            : const Text("Create account", style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ),

                    const SizedBox(height: 30),

                    FadeInUp(
                      duration: const Duration(milliseconds: 2000), 
                      child: Center(
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                          child: const Text("Already have an account?", style: TextStyle(color: Color.fromRGBO(79, 76, 39, 0.6)),
                          )
                        )
                      )
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
