import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/quiz_result_model.dart';

// quiz_result.dart
class QuizResult {
  final String quizId;
  final int score;
  final int timeTaken;
  final DateTime timestamp;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.timeTaken,
    required this.timestamp,
  });

  // Convert QuizResult to QuizResultModel (for the data layer)
  QuizResultModel toDataModel() {
    return QuizResultModel(
      quizId: quizId,
      score: score,
      timeTaken: timeTaken,
      timestamp: Timestamp.fromDate(timestamp),
    );
  }
}
