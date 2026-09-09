import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Row(
          children: [
            Text('Task Name', style: TextStyle(fontWeight: .bold)),
            SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  "(New)",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: .start,
          children: [
            Text("Description"),
            Row(
              children: [
                Text("Date: 20-05-2026", style: TextStyle()),
                Spacer(),
                // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                // IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.edit, size: 20, color: Colors.teal),
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
