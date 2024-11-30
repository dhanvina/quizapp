import 'package:logger/logger.dart';

// entities/question.dart
// Initialize logger instance for logging
final Logger logger = Logger();

class QuizQuestion {
  final String question;
  final double correctOption;
  final List<dynamic>? options;

  QuizQuestion({
    required this.question,
    required this.correctOption,
    this.options,
  }) {
    // Log details when a new QuizQuestion is created
    logger.i('QuizQuestion created: $question');
    if (options != null) {
      logger.i('Options: $options');
    }
    logger.i('Correct option: $correctOption');
  }
}

// entities/quiz.dart
class Quiz {
  final String quizId;
  final String title;
  final String paper;
  final bool isLive;
  final String paperType;
  final int timeLimit;
  final List<QuizQuestion> questions;

  Quiz({
    required this.quizId,
    required this.title,
    required this.paper,
    required this.isLive,
    required this.paperType,
    required this.timeLimit,
    required this.questions,
  });

  // Method to get the count of questions in the quiz
  int get questionCount {
    // Log the count of questions each time it's accessed
    logger.i('Number of questions accessed: ${questions.length}');
    return questions.length;
  }
}
