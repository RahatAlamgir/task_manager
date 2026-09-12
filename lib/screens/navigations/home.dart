import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widget/empty_list.dart';
import 'package:task_manager/widget/task_card.dart';
import 'package:task_manager/widget/task_count_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool haveTask = false;
  List<TaskModel> _allTask = [];

  final TextEditingController _searchController = TextEditingController();

  Future fatchTaskData() async {
    await TaskController.getTaskStatusCount();
    await TaskController.getAllTaskList();

    if (mounted) {
      haveTask = TaskController.taskStatusCount.isNotEmpty;
      _allTask = TaskController.allTaskList;
      setState(() {});
    }
  }

  void _runFilter(String query) {
    List<TaskModel> results = [];
    if (query.isEmpty) {
      results = TaskController.allTaskList;
    } else {
      results = TaskController.allTaskList.where((task) {
        final taskTitle = task.title?.toLowerCase() ?? '';
        final inputQuery = query.toLowerCase().trim();
        return taskTitle.contains(inputQuery);
      }).toList();
    }

    setState(() {
      _allTask = results;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
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
            if (_searchController.text.isEmpty && haveTask) ...[
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: .horizontal,
                  itemCount: TaskController.taskStatusCount.length,

                  itemBuilder: (context, index) {
                    return TaskCountCard(
                      title: TaskController.taskStatusCount[index].sId
                          .toString(),
                      count: TaskController.taskStatusCount[index].sum!.toInt(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8);
                  },
                ),
              ),
              SizedBox(height: 5),
            ],

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
              child: Row(
                children: [
                  Text("My Tasks", style: TextStyle(fontWeight: .w600)),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      //TODO: I have no Idea
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: _searchController.text.isNotEmpty || !haveTask
                  ? 500
                  : 400,
              child: _allTask.isEmpty
                  ? EmptyList(title: "No Task Found")
                  : ListView.builder(
                      itemCount: _allTask.length,
                      itemBuilder: ((context, index) {
                        return TaskCard(
                          task: _allTask[index],
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
