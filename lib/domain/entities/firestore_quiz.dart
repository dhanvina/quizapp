// entities/question.dart
class Question {
  final String question;
  final String correctOption;
  final List<String>? options; // Optional for MCQs

  Question({
    required this.question,
    required this.correctOption,
    this.options,
  });
}

// entities/quiz.dart
class Quiz {
  final String quizId;
  final String title;
  final bool isLive;
  final String paperType;
  final int timeLimit;
  final List<Question> questions;

  Quiz({
    required this.quizId,
    required this.title,
    required this.isLive,
    required this.paperType,
    required this.timeLimit,
    required this.questions,
  });
}
