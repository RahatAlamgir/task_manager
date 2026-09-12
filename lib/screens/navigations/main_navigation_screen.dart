import 'package:flutter/material.dart';
import 'package:task_manager/screens/add_update/add_new_task.dart';
import 'package:task_manager/screens/navigations/completed.dart';
import 'package:task_manager/screens/navigations/home.dart';
import 'package:task_manager/screens/navigations/new_task.dart';
import 'package:task_manager/screens/navigations/progress.dart';
import 'package:task_manager/widget/app_bar_drawer.dart';
import 'package:task_manager/widget/task_app_bar.dart';

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

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TaskAppBar(),
      endDrawer: AppDrawer(refreshParant: refresh),

      body: screens[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddNewTask()),
          );
        },
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
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
