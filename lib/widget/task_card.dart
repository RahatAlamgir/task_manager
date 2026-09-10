import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/model/api_response.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/services/api_caller.dart';
import 'package:task_manager/utils/urls.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.refreshParant});

  final TaskModel task;
  final VoidCallback refreshParant;

  Color getColor(String status) {
    if (status == 'New') {
      return Colors.blue;
    } else if (status == 'In Progress') {
      return Colors.teal;
    } else if (status == 'Completed') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Future deleteTask() async {
    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.deleteURL(task.sId.toString()),
    );
    if (response.isSuccess) {
      refreshParant();
    }
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text("Are you sure you want to delete this task?"),
              Text("Task: ${task.title}", style: TextStyle(fontWeight: .w600)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
                await deleteTask();
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(task.createdDate.toString()).toLocal();

    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                task.title.toString(),
                style: TextStyle(fontWeight: .bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                color: getColor(task.status.toString()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  "(${task.status})",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              task.description.toString(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  "Date: ${DateFormat('MMM dd, yyyy').format(dateTime)}",
                  style: TextStyle(),
                ),
                Spacer(),

                InkWell(
                  onTap: () {},
                  child: Icon(Icons.edit_note, size: 20, color: Colors.teal),
                ),
                SizedBox(width: 14),
                InkWell(
                  onTap: () {
                    deleteDialog(context);
                  },
                  child: Icon(Icons.delete, size: 20, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
