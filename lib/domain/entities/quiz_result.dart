import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../data/models/quiz_result_model.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

// quiz_result.dart
class QuizResult {
  final String quizId;
  final int score;
  final DateTime timestamp;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.timestamp,
  }) {
    // Log details when a QuizResult object is created
    logger.i('QuizResult created: $quizId');
    logger.i('Score: $score');
    logger.i('Timestamp: $timestamp');
  }

  // Convert QuizResult to QuizResultModel (for the data layer)
  QuizResultModel toDataModel() {
    // Log the conversion process
    logger.i('Converting QuizResult to QuizResultModel for quiz: $quizId');

    // Return the QuizResultModel representation of the QuizResult
    return QuizResultModel(
      quizId: quizId,
      score: score,
      // Convert DateTime to Timestamp for Firestore
      timestamp: Timestamp.fromDate(timestamp),
    );
  }

  // Convert Firestore's Timestamp back to DateTime
  static QuizResult fromDataModel(QuizResultModel model) {
    // Convert Timestamp to DateTime
    DateTime timestamp = model.timestamp.toDate();

    // Log the conversion process
    logger.i('Converting QuizResultModel to QuizResult: $model.quizId');

    // Return a QuizResult object
    return QuizResult(
      quizId: model.quizId,
      score: model.score,
      timestamp: timestamp,
    );
  }
}
