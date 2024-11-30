import 'package:logger/logger.dart';
import 'package:quizapp/data/models/quiz_result_model.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class StudentModel {
  final String name;
  final String school;
  final String roll_number;
  final String school_code;
  final bool hasAttemptedLiveQuiz;
  final List<QuizResultModel> quizResults;

  // Constructor for StudentModel
  StudentModel({
    required this.name,
    required this.school,
    required this.roll_number,
    required this.school_code,
    required this.hasAttemptedLiveQuiz,
    required this.quizResults,
  });

  // Factory method to create StudentModel from Firestore data
  factory StudentModel.fromFirestore(Map<String, dynamic> data) {
    logger.i('Creating StudentModel from Firestore data: $data');

    try {
      // Log the Firestore data being processed for debugging
      logger.d('Student Firestore data: $data');

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
    } catch (e, stackTrace) {
      // Log any errors during the conversion process
      logger.e('Error creating StudentModel from Firestore data',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the error to be handled further up the stack
    }
  }

  // Method to convert StudentModel to Firestore data
  Map<String, dynamic> toFirestore() {
    logger.i('Converting StudentModel to Firestore data');

    // Log the model data being converted to Firestore format
    logger.d('StudentModel data: $this');

    return {
      'name': name,
      'school': school,
      'roll_number': roll_number,
      'has_attempted_live_quiz': hasAttemptedLiveQuiz,
      'quiz_results': quizResults.map((e) => e.toFirestore()).toList(),
    };
  }
}
