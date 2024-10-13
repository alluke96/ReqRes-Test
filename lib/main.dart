import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_test/application/blocs/register_bloc.dart';
import 'package:reqres_test/data/data_sources/user_api_data_source.dart';
import 'package:reqres_test/data/repositories/user_repository.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';
import 'package:reqres_test/domain/use_cases/register_user.dart';
import 'package:reqres_test/presentation/pages/login_page.dart';
import 'package:reqres_test/application/blocs/login_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  final httpClient = http.Client();
  final apiDataSource = ApiDataSource(httpClient);
  final userRepository = UserRepository(apiDataSource);
  final loginUserUseCase = LoginUser(userRepository);
  final registerUserUseCase = RegisterUser(userRepository);

  runApp(MyApp(loginUserUseCase: loginUserUseCase, registerUserUseCase: registerUserUseCase));
}

class MyApp extends StatelessWidget {
  final LoginUser loginUserUseCase;
  final RegisterUser registerUserUseCase;

  const MyApp({super.key, required this.loginUserUseCase, required this.registerUserUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(loginUserUseCase: loginUserUseCase)),
        BlocProvider(create: (context) => RegisterBloc(registerUserUseCase: registerUserUseCase)),
      ],
      child: const MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
