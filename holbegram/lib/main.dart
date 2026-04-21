import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/providers/user_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    final usernameController = TextEditingController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        home: Signup(
          emailController: emailController,
          usernameController: usernameController,
          passwordController: passwordController,
          passwordConfirmController: passwordConfirmController,
        ),
        routes: {
          '/home': (context) => const Home(),
          '/login': (context) => LoginScreen(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
          ),
        },
      ),
    );
  }
}
