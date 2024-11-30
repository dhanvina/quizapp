import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../models/firestore_question_model.dart';

/// Data source class for managing quiz-related operations in Firestore.
class QuizDataSource {
  final FirebaseFirestore
      _firestore; // Firestore instance for database interactions.
  final Logger logger; // Logger instance for structured logging.

  /// Constructor to initialize Firestore and Logger.
  QuizDataSource(this._firestore) : logger = Logger();

  /// Fetches all quizzes from the 'quizzes' collection in Firestore.
  Future<List<QuizModel>> getQuizzes() async {
    try {
      logger.i('Fetching quizzes from Firestore...');

      // Retrieve all documents from the 'quizzes' collection.
      final querySnapshot = await _firestore.collection('quizzes').get();

      if (querySnapshot.docs.isEmpty) {
        logger.w('No quizzes found in Firestore.');
        return [];
      }

      logger.i('Successfully fetched quizzes from Firestore.');

      // Optionally, log the first document data for a preview
      if (querySnapshot.docs.isNotEmpty) {
        logger.d('First document data: ${querySnapshot.docs.first.data()}');
      }

      // Convert each document into a QuizModel object and return the list.
      return querySnapshot.docs
          .map((doc) => QuizModel.fromFirestore(doc.data()))
          .toList();
    } catch (e, stackTrace) {
      // Log the error and rethrow it as an exception.
      logger.e('Failed to fetch quizzes from Firestore',
          error: e, stackTrace: stackTrace);
      throw Exception('Failed to fetch quizzes: $e');
    }
  }

  /// Fetches a single quiz by its ID from Firestore.
  Future<QuizModel> fetchQuizById(String quizId) async {
    try {
      logger.i('Fetching quiz with ID: $quizId from Firestore...');

      // Retrieve the document with the specified quiz ID.
      final docSnapshot =
          await _firestore.collection('quizzes').doc(quizId).get();

      if (!docSnapshot.exists) {
        logger.w('Quiz with ID $quizId not found.');
        throw Exception('Quiz with ID $quizId not found');
      }

      final data = docSnapshot.data();
      if (data == null) {
        logger.w('Document data is null for quiz ID: $quizId.');
        throw Exception('Document data is null for quiz $quizId');
      }

      logger.i('Successfully fetched quiz with ID: $quizId.');

      // Merge the Firestore data with the quiz ID and return the QuizModel.
      return QuizModel.fromFirestore({
        ...data,
        'quiz_id': docSnapshot.id,
      });
    } catch (e, stackTrace) {
      logger.e('Failed to fetch quiz with ID $quizId',
          error: e, stackTrace: stackTrace);
      throw Exception('Failed to fetch quiz with ID $quizId: $e');
    }
  }
}
