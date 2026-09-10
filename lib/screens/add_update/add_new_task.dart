import 'package:flutter/material.dart';

import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/screens/navigations/main_navigation_screen.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/task_app_bar.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final double linegap = 15;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future addNewTask() async {
    ApiResponse response = await ApiCaller.postRequest(
      url: Urls.addNewTaskURL,
      body: {
        "title": titleController.text,
        "description": descriptionController.text,
        "status": "New",
      },
    );
    print("add Task ==== ${response.isSuccess}");
    print("add Task ==== ${response.responseCode}");
    if (response.isSuccess) {
      backToMain();
    }
  }

  void backToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationScreen()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAppBar(backButton: backToMain),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 60),
              Text(
                "Add A New Task",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: .bold),
              ),
              SizedBox(height: linegap),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Task Name'),
              ),
              SizedBox(height: linegap),
              TextFormField(
                controller: descriptionController,

                decoration: InputDecoration(hintText: 'Description'),
                maxLines: 6,
              ),
              SizedBox(height: linegap),
              FilledButton(
                onPressed: addNewTask,
                child: Icon(Icons.arrow_circle_right_outlined, size: 22),
              ),
              SizedBox(height: linegap),
            ],
          ),
        ),
      ),
    );
  }
}
