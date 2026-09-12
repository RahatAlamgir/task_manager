import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widget/empty_list.dart';
import 'package:task_manager/widget/task_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<TaskModel> _progressTaskList = [];
  Future fatchTaskData() async {
    await TaskController.getTaskListByStatus('In Progress');

    if (mounted) {
      _progressTaskList = TaskController.taskList;
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
      _progressTaskList = results;
    });
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
              child: Text(
                "In Progress Tasks",
                style: TextStyle(fontWeight: .w600),
              ),
            ),
            SizedBox(
              height: 530,
              child: _progressTaskList.isEmpty
                  ? EmptyList(title: "No In Progress Task Found")
                  : ListView.builder(
                      itemCount: _progressTaskList.length,
                      itemBuilder: ((context, index) {
                        return TaskCard(
                          task: _progressTaskList[index],
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
