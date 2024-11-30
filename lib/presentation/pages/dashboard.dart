import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Logger package
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_preview.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/quiz_provider.dart';
import '../widgets/quiz_section.dart';

class PaperSelectionPage extends StatefulWidget {
  @override
  _PaperSelectionPageState createState() => _PaperSelectionPageState();
}

class _PaperSelectionPageState extends State<PaperSelectionPage> {
  final Logger logger = Logger(); // Logger instance for structured logging

  @override
  void initState() {
    super.initState();

    logger.i('Initializing PaperSelectionPage...');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch quizzes when the widget is built
      logger.i('Fetching quizzes from QuizProvider...');
      Provider.of<QuizProvider>(context, listen: false).fetchQuizzes();
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Building PaperSelectionPage widget tree...');

    final quizProvider = Provider.of<QuizProvider>(context);

    // Separate quizzes into "live" and "practice" categories
    final liveQuizzes =
        quizProvider.quizzes.where((quiz) => quiz.isLive == true).toList();
    final practiceQuizzes =
        quizProvider.quizzes.where((quiz) => quiz.isLive == false).toList();

    logger.d('Live quizzes count: ${liveQuizzes.length}');
    logger.d('Practice quizzes count: ${practiceQuizzes.length}');

    return Scaffold(
      backgroundColor: Constants.limeGreen,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: quizProvider.isLoading
            ? const Center(
                child:
                    CircularProgressIndicator(), // Show loader while quizzes are loading
              )
            : quizProvider.quizzes.isEmpty
                ? const Center(
                    child: Text(
                      "No quizzes available.", // Show message if no quizzes are available
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView(
                    children: [
                      if (liveQuizzes.isNotEmpty)
                        QuizSection(
                          title: "Live Papers", // Section for live quizzes
                          quizzes: liveQuizzes,
                          onPressed: (quiz) {
                            logger.i(
                                'Navigating to QuizPreview for live quiz: ${quiz.title}');
                            logger.d('Quiz data: ${quiz.questions}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPreview(
                                  title: quiz.title,
                                  time: quiz.timeLimit,
                                  paper_type: quiz.paperType,
                                  numberOfQuestions: quiz.questionCount,
                                  isLive: quiz.isLive,
                                  timeLimit: quiz.timeLimit,
                                  quizId: quiz.quizId,
                                  questions: quiz.questions,
                                ),
                              ),
                            );
                          },
                        ),
                      if (practiceQuizzes.isNotEmpty)
                        QuizSection(
                          title:
                              "Practice Papers", // Section for practice quizzes
                          quizzes: practiceQuizzes,
                          onPressed: (quiz) {
                            logger.i(
                                'Navigating to QuizPreview for practice quiz: ${quiz.title}');
                            logger.d('Quiz data: ${quiz.questions}');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPreview(
                                  title: quiz.title,
                                  time: quiz.timeLimit,
                                  paper_type: quiz.paperType,
                                  numberOfQuestions: quiz.questionCount,
                                  isLive: quiz.isLive,
                                  timeLimit: quiz.timeLimit,
                                  quizId: quiz.quizId,
                                  questions: quiz.questions,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
      ),
    );
  }
}
