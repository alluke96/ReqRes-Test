import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:reqres_test/domain/use_cases/login_user.dart';
import 'package:reqres_test/domain/use_cases/logout_user.dart';
import 'package:reqres_test/presentation/pages/login_page.dart';
import 'application/auth_service.dart';
import 'data/data_sources/api_data_source.dart';
import 'data/repositories/user_repository.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        Provider<ApiDataSource>(create: (context) => ApiDataSource(context.read<http.Client>())),
        ProxyProvider<ApiDataSource, UserRepository>(
          update: (_, apiDataSource, __) => UserRepository(apiDataSource),
        ),
        ProxyProvider<UserRepository, LoginUser>(
          update: (_, userRepository, __) => LoginUser(userRepository),
        ),
        ProxyProvider<UserRepository, LogoutUser>(
          update: (_, userRepository, __) => LogoutUser(userRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(context.read<LoginUser>(), context.read<LogoutUser>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
