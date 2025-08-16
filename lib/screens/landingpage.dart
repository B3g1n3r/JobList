import 'package:flutter/material.dart';
import 'package:job_management_app/screens/job_list.dart';

// Assuming JobList is defined as you provided and takes userId and token.
// We'll create placeholder pages for Home, Alerts, Profile for demonstration.

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Home Page', style: TextStyle(fontSize: 24)),
      );
}

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Alerts Page', style: TextStyle(fontSize: 24)),
      );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Profile Page', style: TextStyle(fontSize: 24)),
      );
}

class LandingPage extends StatefulWidget {
  final String userId;
  final String token;

  const LandingPage({Key? key, required this.userId, required this.token})
      : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      JobList(userId: widget.userId, token: widget.token), // Tasks page uses your JobList
      const AlertsScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTap(int idx) {
    if (idx == _currentIndex) return;
    setState(() {
      _currentIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Show selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.notifications_none_outlined),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.red,
                    child: Text(
                      "3",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
