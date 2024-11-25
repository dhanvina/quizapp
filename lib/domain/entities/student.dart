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

// Convert Student to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'school': school,
        'roll_number': roll_number,
        'school_code': school_code,
        'hasAttemptedLiveQuiz': hasAttemptedLiveQuiz,
        'quizResults': quizResults.map((quiz) => quiz.toJson()).toList(),
      };

// Create Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json['name'],
        school: json['school'],
        roll_number: json['roll_number'],
        school_code: json['school_code'],
        hasAttemptedLiveQuiz: json['hasAttemptedLiveQuiz'],
        quizResults: (json['quizResults'] as List)
            .map((quizJson) => QuizResultModel.fromJson(quizJson))
            .toList(),
      );
}
