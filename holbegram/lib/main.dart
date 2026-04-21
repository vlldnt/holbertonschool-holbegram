import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/upload_image_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddPicture(
        email: 'test@example.com',
        password: 'password123',
        username: 'testuser',
      ),
    );
  }
}
