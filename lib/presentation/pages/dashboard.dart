import 'package:flutter/material.dart';
import 'package:quizapp/presentation/widgets/greeting_section.dart';
import 'package:quizapp/presentation/widgets/quiz_card.dart';
import 'package:quizapp/quiz_screen.dart';

class DashboardPage extends StatelessWidget {
  final String fullName;
  DashboardPage(this.fullName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GreetingSection(fullName: fullName),
                    SizedBox(height: 20),
                    Text(
                      "Practice Quizzes",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    QuizCard(
                      title: "Practice 1 - 10 Questions",
                      subtitle: "5 Minutes · Level · Easy",
                      buttonText: "TRY",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen()),
                        );
                      },
                    ),
                    QuizCard(
                      title: "Practice 2 - 20 Questions",
                      subtitle: "10 Minutes · Level · Easy",
                      buttonText: "TRY",
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Live Quizzes",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    QuizCard(
                      title: "Quiz 1 - 20 Questions",
                      subtitle: "10 Minutes · Level · Easy",
                      buttonText: "START",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
