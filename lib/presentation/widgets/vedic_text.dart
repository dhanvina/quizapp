// lib/presentation/widgets/vedic_text.dart
import 'package:flutter/material.dart';
import 'package:quizapp/data/models/vedic_math_model.dart';

class VedicText extends StatelessWidget {
  final VedicMathQuestion question;
  final Function(String) onAnswerChanged;  // Callback for when the answer changes

  const VedicText({
    Key? key,
    required this.question,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: onAnswerChanged,
            decoration: InputDecoration(
              labelText: 'Your Answer',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
