import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/task_app_bar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  Future updatePassword() async {
    if (newPassController.text.length < 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password length is Short")));
      return;
    }
    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.ProfileUpdateURL,
      body: {"password": newPassController.text},
    );
    if (response.isSuccess) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPassController.dispose();
    newPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAppBar(back: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 100),
              Text(
                "Change Password",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: oldPassController,
                decoration: InputDecoration(hintText: 'Old Password'),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: newPassController,
                decoration: InputDecoration(hintText: 'New Password'),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: 15),
              FilledButton(
                onPressed: updatePassword,
                child: Icon(Icons.arrow_circle_right_outlined, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
