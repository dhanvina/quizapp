import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Import logger package
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
    // Initialize the Logger instance
    final logger = Logger();

    return ElevatedButton(
      onPressed: () async {
        // Log the button press event
        logger.i('NextButton pressed for quiz: $title');

        // Navigate to the first motivation screen
        logger.i('Navigating to MotivationScreen1...');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MotivationScreen1()),
        );

        // Log the delay before transitioning to the next screen
        logger
            .i('Waiting for 10 seconds before moving to MotivationScreen2...');
        await Future.delayed(const Duration(seconds: 10));

        // Check if the widget is still mounted (to avoid calling setState after widget dispose)
        if (!context.mounted) return;

        // Navigate to the second motivation screen
        logger.i('Navigating to MotivationScreen2...');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MotivationScreen2()),
        );

        // Log the delay before transitioning to the countdown screen
        logger
            .i('Waiting for 12 seconds before navigating to CountdownPage...');
        await Future.delayed(const Duration(seconds: 12));

        // Check if the widget is still mounted before navigating further
        if (!context.mounted) return;

        // Navigate to the countdown page
        logger.i('Navigating to CountdownPage with quiz details...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountdownPage(
              title: title,
              quizTimeInMinutes: time,
              paperType: paperType,
              numberOfQuestions: numberOfQuestions,
              questions: [], // Empty list of questions for now, can be populated later
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
