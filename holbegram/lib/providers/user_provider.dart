import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/methods/auth_method.dart';

class UserProvider with ChangeNotifier {
  late Users _user;
  final AuthMethode _authMethode = AuthMethode();

  Users get user => _user;
  AuthMethode get authMethode => _authMethode;

  Future<void> refreshUser() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      Users? user = await _authMethode.getUserDetails(userId);
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    }
  }
}
