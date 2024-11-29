import 'package:flutter/material.dart';

import 'quiz_tile.dart';

class QuizSection extends StatelessWidget {
  final String title;
  final List quizzes;
  final void Function(dynamic quiz) onPressed;

  const QuizSection({
    required this.title,
    required this.quizzes,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        ...quizzes.map(
          (quiz) => QuizTile(
            title: quiz.title,
            subtitle: "${quiz.timeLimit} Minutes",
            buttonText: "START",
            onPressed: () {
              onPressed(quiz);
            },
          ),
        ),
      ],
    );
  }
}
