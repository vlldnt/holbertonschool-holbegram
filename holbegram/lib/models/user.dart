import 'package:firebase_database/firebase_database.dart';

class Users {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String photoUrl;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> posts;
  final List<dynamic> saved;
  final String searchKey;

  const Users({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    this.followers = const [],
    this.following = const [],
    this.posts = const [],
    this.saved = const [],
    required this.searchKey,
  });

  static Users fromSnap(DataSnapshot snap) {
    var snapshot = snap.value as Map<dynamic, dynamic>;

    return Users(
      uid: snapshot['uid'] ?? '',
      email: snapshot['email'] ?? '',
      username: snapshot['username'] ?? '',
      bio: snapshot['bio'] ?? '',
      photoUrl: snapshot['photoUrl'] ?? '',
      followers: List<dynamic>.from(snapshot['followers'] ?? []),
      following: List<dynamic>.from(snapshot['following'] ?? []),
      posts: List<dynamic>.from(snapshot['posts'] ?? []),
      saved: List<dynamic>.from(snapshot['saved'] ?? []),
      searchKey: snapshot['searchKey'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'username': username,
    'bio': bio,
    'photoUrl': photoUrl,
    'followers': followers,
    'following': following,
    'posts': posts,
    'saved': saved,
    'searchKey': searchKey,
  };
}
