import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/signup_screen.dart';

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

    return MaterialApp(
      home: Signup(
        emailController: emailController,
        usernameController: usernameController,
        passwordController: passwordController,
        passwordConfirmController: passwordConfirmController,
      ),
    );
  }
}
