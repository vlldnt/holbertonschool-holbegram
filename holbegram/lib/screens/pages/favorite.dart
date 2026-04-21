import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/post.dart';
import 'methods/favorites_service.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: const Center(
          child: Text('Please log in to view favorites'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .orderBy('savedAt', descending: true)
            .snapshots(),
        builder: (context, favSnapshot) {
          if (favSnapshot.hasError) {
            return Center(child: Text('Error: ${favSnapshot.error}'));
          }

          if (favSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!favSnapshot.hasData || favSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No saved posts yet'),
            );
          }

          final favoriteIds = favSnapshot.data!.docs.map((doc) => doc.id).toList();

          return FutureBuilder<List<Post>>(
            future: Future.wait(
              favoriteIds.map((postId) =>
                  FirebaseFirestore.instance.collection('posts').doc(postId).get().then((doc) {
                if (doc.exists) {
                  return Post.fromSnap(doc);
                }
                return null;
              }).then((post) => post!),
              ),
            ),
            builder: (context, postsSnapshot) {
              if (postsSnapshot.hasError) {
                return Center(child: Text('Error: ${postsSnapshot.error}'));
              }

              if (postsSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final posts = postsSnapshot.data ?? [];
              final favoritesService = FavoritesService();

              if (posts.isEmpty) {
                return const Center(child: Text('No saved posts'));
              }

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: post.profImage.isNotEmpty && post.profImage.startsWith('http')
                                      ? NetworkImage(post.profImage)
                                      : null,
                                  child: post.profImage.isEmpty || !post.profImage.startsWith('http')
                                      ? const Icon(Icons.person, color: Colors.grey)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.caption,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[200],
                                ),
                                child: post.postUrl.isNotEmpty && post.postUrl.startsWith('http')
                                    ? Image.network(
                                        post.postUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(Icons.image_not_supported),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.heart, size: 20),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.comment, size: 20),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(FontAwesomeIcons.paperPlane, size: 20),
                                  onPressed: () {},
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons.solidBookmark,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    await favoritesService.unsavePost(post.postId);
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                '${post.likes.length} Liked',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      const Divider(height: 0),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
