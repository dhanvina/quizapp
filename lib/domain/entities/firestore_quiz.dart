// entities/question.dart
class QuizQuestion {
  final String question;
  final String correctOption;
  final List<String>? options;

  QuizQuestion({
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
  final String timeLimit;
  final List<QuizQuestion> questions;

  Quiz({
    required this.quizId,
    required this.title,
    required this.isLive,
    required this.paperType,
    required this.timeLimit,
    required this.questions,
  });
}
