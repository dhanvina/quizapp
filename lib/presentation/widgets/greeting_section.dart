import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  final String fullName;

  const GreetingSection({required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.wb_sunny, color: Colors.black),
                SizedBox(width: 5),
                Text(
                  "GOOD MORNING",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              fullName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // Circular icon
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
