// entities/question.dart
class QuizQuestion {
  final String question;
  final double correctOption;
  final List<dynamic>? options;

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

  int get questionCount => questions.length;
}
