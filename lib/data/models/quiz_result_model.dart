import 'package:logger/logger.dart';

import '../../domain/entities/quiz_result.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class QuizResultModel {
  final String quizId;
  final int score;
  final bool isLive;

  // Constructor for QuizResultModel
  QuizResultModel({
    required this.quizId,
    required this.score,
    required this.isLive,
  });

  // Convert QuizResultModel to QuizResult (for the domain layer)
  QuizResult toDomain() {
    logger.i('Converting QuizResultModel to QuizResult domain model');

    // Log the properties for debugging purposes
    logger.d('quizId: $quizId, score: $score');

    return QuizResult(
      quizId: quizId,
      score: score,
      isLive: isLive,
    );
  }

  // Factory method to convert Firestore data to QuizResultModel
  factory QuizResultModel.fromFirestore(Map<String, dynamic> data) {
    logger.i('Creating QuizResultModel from Firestore data: $data');

    try {
      // Log the Firestore data to ensure correct data is being passed
      logger.d('QuizResult Firestore data: $data');

      return QuizResultModel(
        quizId: data['quiz_id'],
        score: data['score'],
        isLive: data['isLive'] ?? false,
      );
    } catch (e, stackTrace) {
      // Log any errors that occur during the conversion
      logger.e('Error converting Firestore data to QuizResultModel',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow to ensure the error is handled further up the stack
    }
  }

  // Method to convert QuizResultModel to Firestore data
  Map<String, dynamic> toFirestore() {
    logger.i('Converting QuizResultModel to Firestore data');

    // Log the model data being converted to Firestore format
    logger.d('QuizResultModel data: $this');

    return {
      'quiz_id': quizId,
      'score': score,
    };
  }

  // Convert QuizResultModel to JSON (for serialization)
  Map<String, dynamic> toJson() {
    logger.i('Converting QuizResultModel to JSON for serialization');

    // Log the conversion process and data
    logger.d('QuizResultModel data to JSON: quizId: $quizId, score: $score');

    return {
      'quizId': quizId,
      'score': score,
    };
  }

  // Create QuizResultModel from JSON
  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    logger.i('Creating QuizResultModel from JSON: $json');

    try {
      // Log the incoming JSON data for debugging
      logger.d('QuizResultModel JSON data: $json');

      return QuizResultModel(
        quizId: json['quizId'],
        score: json['score'],
        isLive: json['isLive'],
      );
    } catch (e, stackTrace) {
      // Log any errors during JSON parsing
      logger.e('Error creating QuizResultModel from JSON',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the error for further handling
    }
  }
}
