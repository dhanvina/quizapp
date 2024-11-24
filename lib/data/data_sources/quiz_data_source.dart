import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firestore_question_model.dart';

class QuizDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch quizzes from Firestore
  Future<List<QuizModel>> fetchQuizzes() async {
    try {
      final querySnapshot = await _firestore.collection('quizzes').get();
      return querySnapshot.docs.map((doc) {
        return QuizModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch quizzes: $e');
    }
  }

  // Fetch a single quiz by ID (for Abacus type)
  Future<QuizModel> fetchQuizById(String quizId) async {
    try {
      final docSnapshot =
          await _firestore.collection('quizzes').doc(quizId).get();
      if (docSnapshot.exists) {
        return QuizModel.fromFirestore(docSnapshot);
      } else {
        throw Exception('Quiz not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch quiz: $e');
    }
  }
}
