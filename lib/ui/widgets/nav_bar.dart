import 'package:amplify_test/core/mocks/api_screen.dart';
import 'package:amplify_test/ui/screens/feed_screen.dart';
import 'package:amplify_test/ui/screens/setting_screen.dart';
import 'package:amplify_test/ui/screens/story_form_screen.dart';
import 'package:amplify_test/ui/screens/article_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;

  const NavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A4A4A), // Dark gray color
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildNavItem(context, Icons.home_outlined, 0),
            _buildNavItem(context, Icons.add_circle_outline, 1),
            _buildNavItem(context, Icons.settings_outlined, 2),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(BuildContext context, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onLongPress: () => _navigateToScreen(context, index),
        child: Icon(
          icon,
          color: selectedIndex == index ? Colors.blue[700] : Colors.white,
          size: 28,
        ),
      ),
      label: ""
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = const FeedScreen();
        break;
      case 1:
        screen = const StoryFormScreen();
        break;
      case 2:
        screen = const SettingScreen();
        break;
      default:
        return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
}