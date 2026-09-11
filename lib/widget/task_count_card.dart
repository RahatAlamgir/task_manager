import 'package:flutter/material.dart';

class TaskCountCard extends StatelessWidget {
  const TaskCountCard({super.key, required this.count, required this.title});

  final int count;
  final String title;

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

  IconData getIcon(String status) {
    if (status == 'New') {
      return Icons.assignment_add;
    } else if (status == 'In Progress') {
      return Icons.pending_actions;
    } else if (status == 'Completed') {
      return Icons.task;
    } else {
      return Icons.assignment_late;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 110,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color.fromARGB(255, 221, 236, 235),
                foregroundColor: getColor(title),
                child: Icon(getIcon(title), size: 14),
              ),
              Spacer(),
              Text(title, style: TextStyle(fontSize: 12, fontWeight: .bold)),
              Text(count.toString(), style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
