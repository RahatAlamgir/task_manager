import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Avatar
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.teal.shade100,
              child: Text(
                AuthController.userData!.firstName!
                    .substring(0, 1)
                    .toUpperCase(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Detail Cards
            _ProfileDetailTile(
              icon: Icons.person_outline,
              label: 'Full Name',
              value:
                  "${AuthController.userData!.firstName} ${AuthController.userData!.lastName}",
            ),

            const SizedBox(height: 12),
            _ProfileDetailTile(
              icon: Icons.email_outlined,
              label: 'Email Address',
              value: AuthController.userData!.email.toString(),
            ),
            const SizedBox(height: 12),
            _ProfileDetailTile(
              icon: Icons.phone_outlined,
              label: 'Mobile Number',
              value: AuthController.userData!.mobile.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileDetailTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.teal, size: 22),
        ),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
