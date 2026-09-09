import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/screens/login_signup/login_screens.dart';
import 'package:task_manager/screens/navigations/main_navigation_screen.dart';
import 'package:task_manager/utils/assets_path.dart';
import 'package:task_manager/widget/screen_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    AuthController.getUserData();
    bool isLogin = await AuthController.isUserLogin();
    print("is it login === $isLogin");

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLogin ? MainNavigationScreen() : LoginScreens(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(logo: Image.asset(AssetPath.logo, width: 300, height: 300));
  }
}
