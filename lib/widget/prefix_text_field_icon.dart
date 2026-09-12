import 'package:flutter/material.dart';

class prefixTextFieldIcon extends StatelessWidget {
  const prefixTextFieldIcon({super.key, required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(iconData, color: Colors.teal, size: 20),
      ),
    );
  }
}
