import 'package:flutter/material.dart';
import 'package:task_manager/utils/assets_path.dart';

class ScreenBg extends StatelessWidget {
  const ScreenBg({
    super.key,
    this.logo,
    this.child,
    this.resizeToAvoidBottomInset = false,
  });
  final Widget? child;
  final Widget? logo;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
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
