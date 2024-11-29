import 'package:flutter/material.dart';
import 'package:quizapp/presentation/pages/countdown_page.dart';
import 'package:quizapp/presentation/pages/motivation_screen1.dart';
import 'package:quizapp/presentation/pages/motivation_screen2.dart';

class NextButton extends StatelessWidget {
  final String title;
  final int time;
  final String paperType;
  final int numberOfQuestions;

  const NextButton({
    required this.title,
    required this.time,
    required this.paperType,
    required this.numberOfQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MotivationScreen1()),
        );

        await Future.delayed(const Duration(seconds: 10));

        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MotivationScreen2()),
        );

        await Future.delayed(const Duration(seconds: 12));

        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountdownPage(
              title: title,
              quizTimeInMinutes: time,
              paperType: paperType,
              numberOfQuestions: numberOfQuestions,
              questions: [],
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(7),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF00A455),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Text(
          'NEXT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
