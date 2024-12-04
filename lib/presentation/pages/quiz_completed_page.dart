import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/state_management/quiz_provider.dart';
import 'package:quizapp/presentation/widgets/background.dart';

/// Represents the page displayed after completing a quiz.
class QuizCompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the QuizProvider to fetch quiz data like score and questions.
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    // Save the score and update Firestore when the page is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      quizProvider.saveScore();
      final savedScore = await quizProvider.getScore();
      developer.log(
        'Score saved in SharedPreferences: $savedScore',
        name: 'QuizCompletedPage',
      );

      // Firestore integration: Update quiz results in Firestore.
      try {
        developer.log('Attempting to save results to Firestore...');
        await quizProvider.updateQuizResults("BA002", "102", true);
        developer.log('Quiz results saved to Firestore successfully.');
      } catch (e) {
        developer.log('Failed to save quiz results to Firestore: $e');
      }
    });

    // Log the user's score and selected quiz paper information.
    developer.log(
      'Quiz Completed - Score: ${quizProvider.score}, '
      'Total Questions: ${quizProvider.totalQuestions}',
      name: 'QuizCompletedPage',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Completed"),
        backgroundColor: Colors.green, // Green theme for success.
      ),
      body: Stack(
        children: [
          // Background widget providing a farm-themed design.
          const FarmBackgroundWidget(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success icon with styling.
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A455), // Outer circle color.
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, // Border color.
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4), // Shadow color.
                          blurRadius: 30,
                          spreadRadius: 15,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3CB043), // Inner circle color.
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check, // Success checkmark icon.
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Congratulatory message.
                  const Text(
                    "Congratulations!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Display user's score and total questions.
                  Text(
                    "You scored ${quizProvider.score} out of ${quizProvider.totalQuestions}.",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Button to return to the home page.
                  ElevatedButton(
                    onPressed: () {
                      developer.log(
                        'Returning to the home page.',
                        name: 'QuizCompletedPage',
                      );
                      // Navigate back to the first route in the stack.
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF1E1E1E), // Button background.
                      fixedSize: const Size(200, 50), // Button size.
                      padding: EdgeInsets.zero,
                      shadowColor: const Color(0xFF000000), // Shadow color.
                      elevation: 1.24, // Shadow elevation.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Return to Home",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // Text style.
                        color: Colors.white, // Text color.
                        height: 1.33, // Line height.
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
