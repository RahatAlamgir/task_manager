import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';

class TaskAppBar extends StatelessWidget implements PreferredSize {
  const TaskAppBar({super.key, this.logoutButton, this.backButton});

  final VoidCallback? logoutButton;
  final VoidCallback? backButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
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
      actions: [
        logoutButton == null
            ? SizedBox()
            : IconButton(onPressed: logoutButton, icon: Icon(Icons.logout)),
        backButton == null
            ? SizedBox()
            : IconButton(onPressed: backButton, icon: Icon(Icons.arrow_back)),
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
