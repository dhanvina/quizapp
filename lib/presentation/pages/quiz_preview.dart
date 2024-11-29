import 'package:flutter/material.dart';

import '../widgets/ImageSection.dart';
import '../widgets/MainContainer.dart';
import '../widgets/NextButton.dart';
import '../widgets/QuizInfoBox.dart';

class QuizPreview extends StatefulWidget {
  final String title;
  final int time;
  final String paper_type;
  final int numberOfQuestions;

  const QuizPreview({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.numberOfQuestions,
  });

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  String formatTime(int totalMinutes) {
    final int minutes = totalMinutes % 60;
    final int seconds = 0;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
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
            ),
          ],
        ),
      ),
    );
  }
}
