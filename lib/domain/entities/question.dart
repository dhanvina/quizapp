import 'package:logger/logger.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class Question {
  final String type;
  final String question;
  final List<dynamic>? options;
  final double answer;

  Question({
    required this.type,
    required this.question,
    this.options,
    required this.answer,
  }) {
    // Log details whenever a new Question object is created
    logger.i('Question created: $question');
    logger.i('Question type: $type');
    if (options != null) {
      logger.i('Options: $options');
    }
    logger.i('Answer: $answer');
  }
}

class QuestionPaper {
  final String title;
  final int time;
  final String paper_type;
  final List<Question> questions;

  QuestionPaper({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.questions,
  }) {
    // Log details whenever a new QuestionPaper object is created
    logger.i('Question Paper created: $title');
    logger.i('Time limit: $time minutes');
    logger.i('Paper type: $paper_type');
    logger.i('Number of questions: ${questions.length}');
  }

  // Method to get the number of questions in the question paper
  int get questionCount {
    // Log the count of questions each time it's accessed
    logger.i('Number of questions accessed: ${questions.length}');
    return questions.length;
  }
}
