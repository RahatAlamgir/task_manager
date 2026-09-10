import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widget/task_card.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel> completedTaskList = [];
  Future fatchTaskData() async {
    await TaskController.getTaskListByStatus('Completed');

    if (mounted) {
      completedTaskList = TaskController.taskList;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fatchTaskData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "All Completed Tasks",
                style: TextStyle(fontWeight: .w600),
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: completedTaskList.length,
                itemBuilder: ((context, index) {
                  return TaskCard(
                    task: completedTaskList[index],
                    refreshParant: fatchTaskData,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
