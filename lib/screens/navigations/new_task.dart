import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widget/empty_list.dart';
import 'package:task_manager/widget/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<TaskModel> _newTaskList = [];
  Future fatchTaskData() async {
    await TaskController.getTaskListByStatus('New');

    if (mounted) {
      _newTaskList = TaskController.taskList;
      setState(() {});
    }
  }

  void _runFilter(String query) {
    List<TaskModel> results = [];
    if (query.isEmpty) {
      results = TaskController.taskList;
    } else {
      results = TaskController.taskList.where((task) {
        final taskTitle = task.title?.toLowerCase() ?? '';
        final inputQuery = query.toLowerCase().trim();
        return taskTitle.contains(inputQuery);
      }).toList();
    }

    setState(() {
      _newTaskList = results;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                controller: _searchController,
                onChanged: (value) => _runFilter(_searchController.text),
                decoration: InputDecoration(
                  hintText: 'Search Task by Name..',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _runFilter('');
                          },
                        )
                      : null,
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
              child: _newTaskList.isEmpty
                  ? EmptyList(title: "No New Task Found")
                  : ListView.builder(
                      itemCount: _newTaskList.length,
                      itemBuilder: ((context, index) {
                        return TaskCard(
                          task: _newTaskList[index],
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
