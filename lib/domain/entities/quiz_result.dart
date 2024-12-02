import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../data/models/quiz_result_model.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class QuizResult {
  final String quizId;
  final int score;
  final DateTime timestamp;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.timestamp,
  }) {
    logger.i('QuizResult created: $quizId');
    logger.i('Score: $score');
    logger.i('Timestamp: $timestamp');
  }

  // Convert QuizResult to QuizResultModel
  QuizResultModel toDataModel() {
    return QuizResultModel(
      quizId: quizId,
      score: score,
      timestamp: Timestamp.fromDate(timestamp), // Convert DateTime to Timestamp
    );
  }

  // Convert QuizResultModel to QuizResult
  static QuizResult fromDataModel(QuizResultModel model) {
    // Convert Timestamp to DateTime
    DateTime convertedTimestamp = model.timestamp.toDate();

    return QuizResult(
      quizId: model.quizId,
      score: model.score,
      timestamp: convertedTimestamp, // Ensure DateTime type
    );
  }
}
