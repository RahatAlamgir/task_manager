import 'package:flutter/material.dart';
import 'package:task_manager/utils/assets_path.dart';

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
            AssetPath.background,
            fit: .fill,
          ),
          Center(child: logo),
          SingleChildScrollView(child: child),
        ],
      ),
    );
  }
}
