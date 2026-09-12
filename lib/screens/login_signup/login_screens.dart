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
import 'package:task_manager/widget/prefix_text_field_icon.dart';
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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isobscureText = true;

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
    print("my response  ${response.isSuccess}");
    if (response.isSuccess) {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];
      AuthController.saveUserData(model, token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      );
    } else {
      passwordController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMessage.toString())));
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
          key: _formKey,
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
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.email_outlined,
                  ),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
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
              TextFormField(
                controller: passwordController,
                obscureText: isobscureText,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: prefixTextFieldIcon(iconData: Icons.key_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {
                      isobscureText = !isobscureText;
                      setState(() {});
                    },
                    icon: Icon(
                      isobscureText
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 4) {
                    return 'Password must be at least 4 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: linegap),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onTapLogin();
                  }
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
