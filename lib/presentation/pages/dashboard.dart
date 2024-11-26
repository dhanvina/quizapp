import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_preview.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/quiz_provider.dart';

class PaperSelectionPage extends StatefulWidget {
  @override
  _PaperSelectionPageState createState() => _PaperSelectionPageState();
}

class _PaperSelectionPageState extends State<PaperSelectionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).fetchQuizzes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    final liveQuizzes =
        quizProvider.quizzes.where((quiz) => quiz.paper == 'live').toList();
    final practiceQuizzes =
        quizProvider.quizzes.where((quiz) => quiz.paper == 'practice').toList();

    return Scaffold(
      backgroundColor: Constants.limeGreen,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: quizProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : quizProvider.quizzes.isEmpty
                ? const Center(
                    child: Text(
                      "No quizzes available.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView(
                    children: [
                      if (liveQuizzes.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Live Papers",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ...liveQuizzes.map((quiz) => QuizTile(
                              title: quiz.title,
                              subtitle: "${quiz.timeLimit} Minutes",
                              buttonText: "START",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizPreview(
                                      title: quiz.title,
                                      time: quiz.timeLimit,
                                      paper_type: quiz.paperType,
                                      numberOfQuestions: quiz.questionCount,
                                    ),
                                  ),
                                );
                              },
                            )),
                      ],
                      if (practiceQuizzes.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Practice Papers",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ...practiceQuizzes.map((quiz) => QuizTile(
                              title: quiz.title,
                              subtitle: "${quiz.timeLimit} Minutes",
                              buttonText: "TRY",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizPreview(
                                      title: quiz.title,
                                      time: quiz.timeLimit,
                                      paper_type: quiz.paperType,
                                      numberOfQuestions: quiz.questionCount,
                                    ),
                                  ),
                                );
                              },
                            )),
                      ],
                    ],
                  ),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const QuizTile({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book, color: Constants.green, size: 40),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.green,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
