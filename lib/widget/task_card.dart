import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/model/task_model.dart';

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

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(task.createdDate.toString()).toLocal();

    return Card(
      color: Colors.white,
      elevation: 0,
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
                  onTap: () {},
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
