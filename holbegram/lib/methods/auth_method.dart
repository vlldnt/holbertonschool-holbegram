import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import '../screens/auth/user_storage.dart';

class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      String photoUrl = '';
      if (file != null) {
        final uploadedUrl = await StorageMethods().uploadImageToStorage(
          file,
          'profile_pictures',
        );
        if (uploadedUrl == null) {
          return 'Failed to upload image';
        }
        photoUrl = uploadedUrl;
      }

      Users users = Users(
        uid: user!.uid,
        email: email,
        username: username,
        bio: '',
        photoUrl: photoUrl,
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: username[0],
      );
      await _firestore.collection('users').doc(user.uid).set(users.toJson());
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }

  Future<Users?> getUserDetails(String userId) async {
    try {
      final userData = await _firestore.collection('users').doc(userId).get();
      if (!userData.exists) {
        return null;
      }
      return Users.fromSnapshot(userData);
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
