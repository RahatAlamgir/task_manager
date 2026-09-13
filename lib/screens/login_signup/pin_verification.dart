import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_bg.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
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
              "Pin Verification",
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
            MaterialPinField(
              length: 6,
              onCompleted: (pin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Who Gave You this Pin")),
                );
              },
              onChanged: (value) => print('Changed: $value'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              theme: MaterialPinTheme(
                shape: MaterialPinShape.outlined,
                borderWidth: 0,
                fillColor: Colors.white,
                focusedFillColor: Colors.white,
                cellSize: Size(48, 50),
                borderRadius: BorderRadius.circular(12),
              ),
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
