import 'package:flutter/material.dart';
import 'package:quizapp/quiz_screen.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return MobileDashboard();
            } else if (constraints.maxWidth < 1200) {
              // Tablet layout
              return TabletDashboard();
            } else {
              // Web layout
              return WebDashboard();
            }
          },
        ),
      ),
    );
  }
}

// Mobile layout
class MobileDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreetingSection(),
          SizedBox(height: 20),
          Text(
            "Practice Quizzes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          SizedBox(height: 20),
          Text(
            "Live Quizzes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          QuizCard(
            title: "Quiz 1 - 20 Questions",
            subtitle: "10 Minutes · Level · Easy",
            buttonText: "START",
          ),
        ],
      ),
    );
  }
}

// Tablet layout
class TabletDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingSection(),
                SizedBox(height: 20),
                Text(
                  "Practice Quizzes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                SizedBox(height: 20),
                Text(
                  "Live Quizzes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }
}

// Web layout
class WebDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(48.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreetingSection(),
                SizedBox(height: 20),
                Text(
                  "Practice Quizzes",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    );
  }
}

// Greeting Section
class GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.wb_sunny, color: Colors.black),
                SizedBox(width: 5),
                Text(
                  "GOOD MORNING",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "Dhanvina",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // Circular icon
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

class QuizCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onPressed; // Add this parameter for the button's action

  const QuizCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onPressed, // Accept onPressed in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.quiz, size: 40, color: Colors.black),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onPressed, // Use the passed onPressed callback
              child: Text(buttonText),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
