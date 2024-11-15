import 'package:flutter/material.dart';

class VedicText extends StatelessWidget {
  final String questionText;
  final ValueChanged<String> onAnswerChanged;

  const VedicText({
    required this.questionText,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(questionText), // Displaying the question text directly
        TextField(
          onChanged: onAnswerChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter your answer',
          ),
        ),
      ],
    );
  }
}
