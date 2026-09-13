import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/screens/login_signup/pin_verification.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/prefix_text_field_icon.dart';
import 'package:task_manager/widget/screen_bg.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  double linegap = 15;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future verifyEmail() async {
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.VerifyEmail(emailController.text),
    );
    if (response.isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PinVerification()),
      );
    }
  }

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
        child: Form(
          key: _formKey,
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
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.email_outlined,
                  ),
                ),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),

              SizedBox(height: linegap),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    verifyEmail();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PinVerification(),
                      ),
                    );
                  }
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
      ),
    );
  }
}
