import 'package:flutter/material.dart';

class QuizInfoBox extends StatelessWidget {
  final String title;
  final int numberOfQuestions;
  final String formattedTime;

  const QuizInfoBox({
    super.key,
    required this.title,
    required this.numberOfQuestions,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 210,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            "There are a total of $numberOfQuestions questions",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            "Time - $formattedTime",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
