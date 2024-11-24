// student.dart
import '../../data/models/quiz_result_model.dart';

class Student {
  final String name;
  final String school;
  final String roll_number;
  final String school_code;
  final bool hasAttemptedLiveQuiz;
  final List<QuizResultModel> quizResults;

  Student({
    required this.name,
    required this.school,
    required this.roll_number,
    required this.school_code,
    required this.hasAttemptedLiveQuiz,
    required this.quizResults,
  });
}
