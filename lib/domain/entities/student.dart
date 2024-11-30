import 'package:logger/logger.dart';

import '../../data/models/quiz_result_model.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

// student.dart
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
  }) {
    // Log the creation of a Student object
    logger.i('Student created: $name, $roll_number, $school_code');
  }

  // Convert Student to JSON
  Map<String, dynamic> toJson() {
    // Log the process of converting Student to JSON
    logger.i('Converting Student to JSON for: $name');
    return {
      'name': name,
      'school': school,
      'roll_number': roll_number,
      'school_code': school_code,
      'hasAttemptedLiveQuiz': hasAttemptedLiveQuiz,
      'quizResults': quizResults.map((quiz) => quiz.toJson()).toList(),
    };
  }

  // Create Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    // Log the process of creating Student from JSON
    logger.i(
        'Creating Student from JSON for roll number: ${json['roll_number']}');

    return Student(
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
}
