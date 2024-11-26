import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firestore_question_model.dart';

class QuizDataSource {
  final FirebaseFirestore _firestore;

  QuizDataSource(this._firestore);

  // Fetch quizzes from Firestore
  Future<List<QuizModel>> getQuizzes() async {
    try {
      final querySnapshot = await _firestore.collection('quizzes').get();

      // Debug: Log the raw data
      for (var doc in querySnapshot.docs) {
        print('Document data: ${doc.data()}');
      }

      return querySnapshot.docs
          .map((doc) => QuizModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch quizzes: $e');
    }
  }

  // Fetch a single quiz by ID
  Future<QuizModel> fetchQuizById(String quizId) async {
    try {
      final docSnapshot =
          await _firestore.collection('quizzes').doc(quizId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          return QuizModel.fromFirestore({
            ...data,
            'quiz_id': docSnapshot.id,
          });
        } else {
          throw Exception('Document data is null for quiz $quizId');
        }
      } else {
        throw Exception('Quiz with ID $quizId not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch quiz with ID $quizId: $e');
    }
  }
}
