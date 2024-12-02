import 'package:flutter/material.dart';

import '../../domain/entities/firestore_quiz.dart';

class QuestionText extends StatefulWidget {
  final List<QuizQuestion> questions;
  final int currentIndex; // Index of the current question to display

  const QuestionText(
      {Key? key, required this.questions, required this.currentIndex})
      : super(key: key);

  @override
  _QuestionTextState createState() => _QuestionTextState();
}

class _QuestionTextState extends State<QuestionText> {
  @override
  Widget build(BuildContext context) {
    // Get the current question using the index
    final question = widget.questions[widget.currentIndex];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        question
            .question, // Display the question text from the QuizQuestion object
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
