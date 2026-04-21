import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/user_storage.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost({
    required String caption,
    required String uid,
    required String username,
    required String profImage,
    required Uint8List image,
  }) async {
    try {
      final imageUrl = await StorageMethods().uploadImageToStorage(
        image,
        'posts',
      );

      if (imageUrl == null) {
        return 'Failed to upload image';
      }

      final postId = _firestore.collection('posts').doc().id;
      final post = {
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'postUrl': imageUrl,
        'likes': [],
        'postId': postId,
        'datePublished': DateTime.now(),
      };

      await _firestore.collection('posts').doc(postId).set(post);
      return 'Ok';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String postId, String publicId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}
