// presentation/pages/quiz_completed_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/widgets/background.dart';

import '../state_management/question_provider.dart';

class QuizCompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Completed"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          const FarmBackgroundWidget(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Congratulations!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "You scored ${questionProvider.score} out of ${questionProvider.papers[questionProvider.selectedPaperIndex].questions.length}.",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF1E1E1E), // Button background color
                      fixedSize: Size(200, 50), // Button width and height
                      padding: EdgeInsets.zero,
                      shadowColor: Color(0xFF000000), // Shadow color
                      elevation: 1.24, // Drop shadow elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Return to Home",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // Poppins Semibold
                        color: Colors.white, // Text color
                        height: 1.33, // Line height, calculated as 29.7/22.3
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
