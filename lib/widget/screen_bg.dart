import 'package:flutter/material.dart';

class ScreenBg extends StatelessWidget {
  const ScreenBg({super.key, this.logo, this.child});
  final Widget? child;
  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: double.infinity,
            height: double.infinity,
            "assets/background.png",
            fit: .fill,
          ),
          Center(child: logo),
          SingleChildScrollView(child: child),
        ],
      ),
    );
  }
}
