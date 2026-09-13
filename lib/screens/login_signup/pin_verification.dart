import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/screen_bg.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  double linegap = 15;
  PinInputController _pinController = PinInputController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future verifyOTP(String email) async {
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.VerifyOTP(email, _pinController.text),
    );
    if (response.isSuccess) {
      //TODO:: New Password Screen
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinController.dispose();
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
                pinController: _pinController,
                length: 6,
                onCompleted: (pin) {
                  //TODO:: New Password Screen
                  verifyOTP("test@gmail.com");
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
                  //TODO:: New Password Screen
                  verifyOTP("test@gmail.com");
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
      ),
    );
  }
}
