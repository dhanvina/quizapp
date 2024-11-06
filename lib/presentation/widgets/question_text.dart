// question_text.dart
import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String question;

  const QuestionText({required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        question,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
