import 'package:flutter/material.dart';
import 'package:workoutamw/screens/workout.dart';
import 'package:workoutamw/screens/history.dart';
import 'package:workoutamw/screens/home_screen.dart';

class HomeAfterLoginPage extends StatefulWidget {
  const HomeAfterLoginPage({super.key});

  static String id = 'home_after_login_page'; // Add this line

  @override
  // ignore: library_private_types_in_public_api
  _HomeAfterLoginPageState createState() => _HomeAfterLoginPageState();
}

class _HomeAfterLoginPageState extends State<HomeAfterLoginPage> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<bool> _onWillPop() async {
    return await _showLogoutConfirmationDialog();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WORKOUT TRACKER'),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                bool shouldLogout = await _showLogoutConfirmationDialog();
                if (shouldLogout) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              },
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const [
            WorkoutPage(),
            HistoryPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Workout',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
