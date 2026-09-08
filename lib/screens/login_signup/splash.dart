import 'package:flutter/material.dart';
import 'package:task_manager/screens/login_signup/login_screens.dart';
import 'package:task_manager/widget/screen_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreens()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      logo: Image.asset("assets/logo.png", width: 300, height: 300),
    );
  }
}
