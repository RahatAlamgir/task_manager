import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_bg.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  double linegap = 15;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 150),
            Text(
              "Get Started With",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(height: linegap),
            FilledButton(
              onPressed: () {},
              child: Icon(Icons.arrow_circle_right_outlined, size: 22),
            ),
            SizedBox(height: linegap),
            Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget password..?",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Dont have a account? ',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 14,
                            fontWeight: .bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
