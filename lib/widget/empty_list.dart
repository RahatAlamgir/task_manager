import 'package:flutter/material.dart';
import 'package:task_manager/utils/assets_path.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 80),
          Image.asset(AssetPath.noTask, height: 120),
          SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}
