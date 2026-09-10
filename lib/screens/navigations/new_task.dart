import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widget/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskModel> newTaskList = [];
  Future fatchTaskData() async {
    await TaskController.getTaskListByStatus('New');

    if (mounted) {
      newTaskList = TaskController.taskList;
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
              child: Text("All New Tasks", style: TextStyle(fontWeight: .w600)),
            ),
            SizedBox(
              height: 530,
              child: ListView.builder(
                itemCount: newTaskList.length,
                itemBuilder: ((context, index) {
                  return TaskCard(
                    task: newTaskList[index],
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
