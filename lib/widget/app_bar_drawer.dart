import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/screens/login_signup/login_screens.dart';
import 'package:task_manager/screens/profile/profile.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const AppDrawer({super.key, required this.onLogout});

  void logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),

          content: Text("Are you sure you want to Logout?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                AuthController.clearData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreens()),
                  (route) => false,
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // User Header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Color.fromARGB(255, 1, 112, 101)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundImage: NetworkImage(
                "https://img.magnific.com/premium-vector/wavy-hair-caucasian-man-relaxed-standing-2d-vector-avatar-illustration-cheerful-western-european-male-cartoon-character-face-confident-headshot-posing-flat-color-user-profile-image-isolated-white_151150-21132.jpg?semt=ais_hybrid&w=740&q=80",
              ),
            ),
            accountName: Text(
              "${AuthController.userData?.firstName ?? 'User'} ${AuthController.userData?.lastName ?? ''}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: Text(
              AuthController.userData?.email ?? 'example@email.com',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),

          Expanded(
            child: ListView(
              padding: .zero,
              children: [
                _DrawerTile(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                    ProfileScreen();
                  },
                ),
                _DrawerTile(
                  icon: Icons.manage_accounts_outlined,
                  title: 'Update Profile',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Update Profile
                  },
                ),
                _DrawerTile(
                  icon: Icons.lock_reset_outlined,
                  title: 'Change Password',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Change Password
                  },
                ),
                _DrawerTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Settings
                  },
                ),
                const Divider(indent: 16, endIndent: 16),
                _DrawerTile(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  onTap: () {
                    Navigator.pop(context);
                    logoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      onTap: onTap,
    );
  }
}
