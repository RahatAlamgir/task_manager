import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/screens/login_signup/signup_screens.dart';
import 'package:task_manager/screens/navigations/main_navigation_screen.dart';
import 'package:task_manager/screens/profile/forget_password.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onTapSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreens()),
    );
  }

  void onTapLogin() async {
    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginURL,
      body: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );
    if (response.isSuccess) {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];
      AuthController.saveUserData(model, token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      );
    }
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
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
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
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: linegap),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: linegap),
              FilledButton(
                onPressed: () {
                  onTapLogin();
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 22),
              ),
              SizedBox(height: linegap),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ),
                        );
                      },
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = onTapSignUpScreen,
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
      ),
    );
  }
}
