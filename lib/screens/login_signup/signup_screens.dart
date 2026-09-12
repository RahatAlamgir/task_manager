import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/prefix_text_field_icon.dart';
import 'package:task_manager/widget/screen_bg.dart';

class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});

  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {
  final double _linegap = 15;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isobscureText = true;

  void onTapSignUp() async {
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.signUpURL,
      body: {
        "email": _emailController.text,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "mobile": _mobileController.text,
        "password": _passwordController.text,
      },
    );
    if (response.isSuccess) {
      backToLoginScreen();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMessage.toString())));
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
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      resizeToAvoidBottomInset: true,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
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
              SizedBox(height: _linegap),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.email_outlined,
                  ),
                ),
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
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: _linegap),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.person_outline,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your First Name';
                  }

                  return null;
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: _linegap),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.person_outline,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Last Name';
                  }

                  return null;
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: _linegap),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  hintText: 'Mobile',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.phone_outlined,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your mobile number';
                  }

                  final cleanValue = value.trim();

                  final phoneRegex = RegExp(r'^\+?[0-9]{10,14}$');

                  if (!phoneRegex.hasMatch(cleanValue)) {
                    return 'Please enter a valid mobile number';
                  }

                  return null; // Valid
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: _linegap),
              TextFormField(
                controller: _passwordController,
                obscureText: _isobscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: prefixTextFieldIcon(iconData: Icons.key_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _isobscureText = !_isobscureText;
                      setState(() {});
                    },
                    icon: Icon(
                      _isobscureText
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
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: _linegap),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onTapSignUp();
                  }
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 22),
              ),
              SizedBox(height: _linegap),
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
      ),
    );
  }
}
