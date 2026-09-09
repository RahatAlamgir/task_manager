import 'package:flutter/material.dart';

class TaskCountCard extends StatelessWidget {
  const TaskCountCard({super.key, required this.count, required this.title});

  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: SizedBox(
        width: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color.fromARGB(255, 221, 236, 235),
                foregroundColor: Colors.teal,
                child: Icon(Icons.task, size: 14),
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
