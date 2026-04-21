import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> savePost(String postId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(postId)
        .set({
      'postId': postId,
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> unsavePost(String postId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(postId)
        .delete();
  }

  Future<bool> isPostSaved(String postId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final doc = await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(postId)
        .get();

    return doc.exists;
  }

  Stream<List<String>> getUserFavorites() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty();
    }

    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }
}
