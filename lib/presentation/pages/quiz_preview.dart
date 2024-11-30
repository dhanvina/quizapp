import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../widgets/ImageSection.dart';
import '../widgets/MainContainer.dart';
import '../widgets/NextButton.dart';
import '../widgets/QuizInfoBox.dart';

class QuizPreview extends StatefulWidget {
  final String title;
  final int time;
  final String paper_type;
  final int numberOfQuestions;
  final bool isLive;
  final int timeLimit;
  final String quizId;
  final List<QuizQuestion> questions;

  const QuizPreview({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.numberOfQuestions,
    required this.isLive,
    required this.timeLimit,
    required this.quizId,
    required this.questions,
  });

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  // Logger instance for logging
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();

    // Log basic details about the quiz
    logger.i('QuizPreview initialized with title: ${widget.title}');
    logger.i('Number of Questions: ${widget.numberOfQuestions}');

    // Log each question
    for (var i = 0; i < widget.questions.length; i++) {
      logger.d('Question ${i + 1}: ${widget.questions[i]}');
    }
  }

  String formatTime(int totalMinutes) {
    final int minutes = totalMinutes % 60;
    final int seconds = 0;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // Log that the quiz preview is being built
    logger.i('Building QuizPreview for: ${widget.title}');

    return Center(
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageSection(),
            SizedBox(height: 8.0),
            QuizInfoBox(
              title: widget.title,
              numberOfQuestions: widget.numberOfQuestions,
              formattedTime: formatTime(widget.time),
            ),
            SizedBox(height: 20.0),
            NextButton(
              title: widget.title,
              time: widget.time,
              paperType: widget.paper_type,
              numberOfQuestions: widget.numberOfQuestions,
              isLive: widget.isLive,
              timeLimit: widget.timeLimit,
              quizId: widget.quizId,
              questions: widget.questions,
            ),
          ],
        ),
      ),
    );
  }
}
