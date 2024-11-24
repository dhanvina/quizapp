import 'package:quizapp/data/models/quiz_result_model.dart';

class StudentModel {
  final String name;
  final String school;
  final String roll_number;
  final String school_code;
  final bool hasAttemptedLiveQuiz;
  final List<QuizResultModel> quizResults;

  StudentModel({
    required this.name,
    required this.school,
    required this.roll_number,
    required this.school_code,
    required this.hasAttemptedLiveQuiz,
    required this.quizResults,
  });

  factory StudentModel.fromFirestore(Map<String, dynamic> data) {
    return StudentModel(
      name: data['name'],
      school: data['school'],
      roll_number: data['roll_number'],
      school_code: data['school_code'],
      hasAttemptedLiveQuiz: data['has_attempted_live_quiz'],
      quizResults: (data['quiz_results'] as List<dynamic>)
          .map((e) => QuizResultModel.fromFirestore(e))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'school': school,
      'roll_number': roll_number,
      'has_attempted_live_quiz': hasAttemptedLiveQuiz,
      'quiz_results': quizResults.map((e) => e.toFirestore()).toList(),
    };
  }
}
