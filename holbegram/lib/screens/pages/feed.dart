import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:holbegram/utils/posts.dart';

class Feed extends StatelessWidget {
  final PageController? pageController;

  const Feed({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/logo.png',
              height: 32,
              width: 32,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              pageController?.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInBack,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.message,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const Posts(),
    );
  }
}
