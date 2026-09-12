import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_bg.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  double linegap = 15;
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

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
              "Your Email Address",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
            ),
            SizedBox(height: 10),
            Text(
              'A 6 digit verification pin will send to your email address',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),

            SizedBox(height: linegap),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Forget Password is not supported")),
                );
              },
              child: Icon(Icons.arrow_circle_right_outlined, size: 22),
            ),
            SizedBox(height: linegap),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'have account? ',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: .bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
