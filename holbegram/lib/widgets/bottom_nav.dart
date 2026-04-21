import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/pages/feed.dart';
import '../screens/pages/search.dart';
import '../screens/pages/add_image.dart';
import '../screens/pages/favorite.dart';
import '../screens/pages/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInBack,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Feed(pageController: _pageController),
          const Search(),
          const AddImage(),
          const Favorite(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: onPageChanged,
        items: [
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.house),
            title: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: const Text(
                'Home',
                style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
              ),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            title: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: const Text(
                'Search',
                style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
              ),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.plus),
            title: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
              ),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.heart),
            title: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: const Text(
                'Likes',
                style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
              ),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.user),
            title: Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: const Text(
                'Profile',
                style: TextStyle(fontSize: 25, fontFamily: 'Billabong'),
              ),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
