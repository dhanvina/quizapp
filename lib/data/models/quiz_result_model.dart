// quiz_result_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/quiz_result.dart';

class QuizResultModel {
  final String quizId;
  final int score;
  final int timeTaken;
  final Timestamp timestamp;

  QuizResultModel({
    required this.quizId,
    required this.score,
    required this.timeTaken,
    required this.timestamp,
  });

  // Convert QuizResultModel to QuizResult (for the domain layer)
  QuizResult toDomain() {
    return QuizResult(
      quizId: quizId,
      score: score,
      timeTaken: timeTaken,
      timestamp: timestamp.toDate(),
    );
  }

  // Factory method to convert Firestore data to QuizResultModel
  factory QuizResultModel.fromFirestore(Map<String, dynamic> data) {
    return QuizResultModel(
      quizId: data['quiz_id'],
      score: data['score'],
      timeTaken: data['time_taken'],
      timestamp: data['timestamp'],
    );
  }

  // Method to convert QuizResultModel to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'quiz_id': quizId,
      'score': score,
      'time_taken': timeTaken,
      'timestamp': timestamp,
    };
  }
}
