import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/screen_bg.dart';

class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});

  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {
  double linegap = 15;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void onTapSignUp() async {
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.signUpURL,
      body: {
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "mobile": mobileController.text,
        "password": passwordController.text,
      },
    );
    if (response.isSuccess) {
      backToLoginScreen();
    }
  }

  void backToLoginScreen() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 100),
            Text(
              "Join With Us",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(hintText: 'First Name'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(hintText: 'Last Name'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: mobileController,
              decoration: InputDecoration(hintText: 'Mobile'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            SizedBox(height: linegap),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
            SizedBox(height: linegap),
            FilledButton(
              onPressed: onTapSignUp,
              child: Icon(Icons.arrow_circle_right_outlined, size: 22),
            ),
            SizedBox(height: linegap),
            Center(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Already have account? ',
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
                            ..onTap = backToLoginScreen,
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
