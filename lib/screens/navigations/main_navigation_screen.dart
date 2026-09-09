import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/screens/login_signup/login_screens.dart';
import 'package:task_manager/screens/navigations/completed.dart';
import 'package:task_manager/screens/navigations/home.dart';
import 'package:task_manager/screens/navigations/new_task.dart';
import 'package:task_manager/screens/navigations/progress.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    NewTaskScreen(),
    ProgressScreen(),
    CompletedScreen(),
  ];

  IconButton navigationItem(IconData icon, int index) {
    bool isActive = _selectedIndex == index;

    return IconButton(
      icon: Icon(
        icon,
        size: isActive ? 28 : 24,
        color: isActive ? Colors.teal : Colors.grey,
      ),
      onPressed: () => setState(() => _selectedIndex = index),
    );
  }

  void logout() {
    AuthController.clearData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreens()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.tealAccent,
                foregroundImage: NetworkImage(
                  "https://img.magnific.com/premium-vector/wavy-hair-caucasian-man-relaxed-standing-2d-vector-avatar-illustration-cheerful-western-european-male-cartoon-character-face-confident-headshot-posing-flat-color-user-profile-image-isolated-white_151150-21132.jpg?semt=ais_hybrid&w=740&q=80",
                ),
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "${AuthController.userData!.firstName} ${AuthController.userData!.lastName}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                    fontWeight: .bold,
                  ),
                ),
                Text(
                  AuthController.userData!.email.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),

      body: screens[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        shape: const CircleBorder(),
        elevation: 2.0,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        elevation: 4,
        height: 65,
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // Creates the cutout curve
        notchMargin: 8.0, // Space between the FAB and the bar
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Tab 0: Home
            navigationItem(Icons.home, 0),
            navigationItem(Icons.assignment, 1),
            const SizedBox(width: 48),
            navigationItem(Icons.pending_actions, 2),
            navigationItem(Icons.assignment_turned_in, 3),
          ],
        ),
      ),
    );
  }
}
