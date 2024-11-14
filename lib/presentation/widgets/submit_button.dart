// submit_button.dart
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellowAccent,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: Text("Submit"),
      ),
    );
  }
}
