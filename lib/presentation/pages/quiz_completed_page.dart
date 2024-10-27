// presentation/pages/quiz_completed_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Center(
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
                child: Text("Return to Home"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
