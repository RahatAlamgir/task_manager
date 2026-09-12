import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

import 'package:task_manager/widget/task_app_bar.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.refreshParant});

  final VoidCallback refreshParant;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController emailController = TextEditingController(
    text: AuthController.userData!.email,
  );
  TextEditingController firstNameController = TextEditingController(
    text: AuthController.userData!.firstName,
  );
  TextEditingController lastNameController = TextEditingController(
    text: AuthController.userData!.lastName,
  );
  TextEditingController mobileController = TextEditingController(
    text: AuthController.userData!.mobile,
  );

  String checkEmpty() {
    return '';
  }

  Future updateProfile() async {
    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.ProfileUpdateURL,
      body: {
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "mobile": mobileController.text,
      },
    );

    if (response.isSuccess) {
      UserModel model = UserModel(
        sId: AuthController.userData?.sId,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
      );
      AuthController.updateUserData(model);
      widget.refreshParant();

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.responseData)));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
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
              SizedBox(height: 80),
              Text(
                "Update Profile",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
              ),

              SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'First Name',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.person_outline,
                  ),
                ),
                controller: firstNameController,

                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.person_outline,
                  ),
                ),
                controller: lastNameController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Mobile',
                  prefixIcon: prefixTextFieldIcon(
                    iconData: Icons.phone_outlined,
                  ),
                ),
                controller: mobileController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: 15),
              FilledButton(
                onPressed: updateProfile,
                child: Icon(Icons.arrow_circle_right_outlined, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class prefixTextFieldIcon extends StatelessWidget {
  const prefixTextFieldIcon({super.key, required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(iconData, color: Colors.teal, size: 20),
      ),
    );
  }
}
