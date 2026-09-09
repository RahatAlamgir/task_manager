import 'package:flutter/material.dart';
import 'package:task_manager/widget/task_card.dart';
import 'package:task_manager/widget/task_count_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: .horizontal,
                itemCount: 4,

                itemBuilder: (context, index) {
                  return TaskCountCard(title: "Completed", count: 25);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 8);
                },
              ),
            ),
            SizedBox(height: 5),

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
              child: Row(
                children: [
                  Text("My Tasks", style: TextStyle(fontWeight: .w600)),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View all",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: ((context, index) {
                  return TaskCard();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
