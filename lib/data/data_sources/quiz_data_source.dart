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
        final docData = doc.data();
        print('Document data: $docData');

        // Check the type of each field
        docData.forEach((key, value) {
          print('Field: $key, Value: $value, Type: ${value.runtimeType}');
        });

        // Check and convert the 'options' field to a list of integers
        if (docData['questions'] is List) {
          List<dynamic> questions = docData['questions'];
          questions.forEach((question) {
            print('Checking question: $question');
            if (question is Map) {
              // Ensure the 'options' field is a list of integers
              final options = question['options'];
              if (options is List) {
                print('Options is a list: $options');
                options.forEach((option) {
                  if (option is int) {
                    print('Option is an integer: $option');
                  } else if (option is String) {
                    // If the option is a string, you can try to convert it to an integer
                    final optionInt = int.tryParse(option);
                    print('Converted option to integer: $optionInt');
                  } else {
                    print('Unknown type for option: $option');
                  }
                });
              } else {
                print('Options is not a list');
              }
            }
          });
        }
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
