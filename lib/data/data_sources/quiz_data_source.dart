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
  ///
  /// Returns:
  /// - A list of [QuizModel] objects representing all quizzes.
  /// - Throws an exception if the fetch operation fails.
  Future<List<QuizModel>> getQuizzes() async {
    try {
      logger.i('Fetching quizzes from Firestore...');

      // Retrieve all documents from the 'quizzes' collection.
      final querySnapshot = await _firestore.collection('quizzes').get();

      // Iterate through each document to log its data and analyze fields.
      for (var doc in querySnapshot.docs) {
        final docData = doc.data();
        logger.d('Document data: $docData');

        // Log the field types and values.
        docData.forEach((key, value) {
          logger.d('Field: $key, Value: $value, Type: ${value.runtimeType}');
        });

        // Check and validate the 'options' field in the 'questions' field.
        if (docData['questions'] is List) {
          List<dynamic> questions = docData['questions'];
          for (var question in questions) {
            logger.d('Checking question: $question');
            if (question is Map) {
              final options = question['options'];
              if (options is List) {
                logger.d('Options is a list: $options');
                for (var option in options) {
                  if (option is int) {
                    logger.d('Option is an integer: $option');
                  } else if (option is String) {
                    // Convert string options to integers if applicable.
                    final optionInt = int.tryParse(option);
                    logger.d('Converted option to integer: $optionInt');
                  } else {
                    logger.w('Unknown type for option: $option');
                  }
                }
              } else {
                logger.w('Options is not a list for question: $question');
              }
            }
          }
        }
      }

      logger.i('Successfully fetched quizzes from Firestore.');

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
  ///
  /// Parameters:
  /// - `quizId`: The ID of the quiz to be fetched.
  ///
  /// Returns:
  /// - A [QuizModel] object representing the quiz if it exists.
  /// - Throws an exception if the quiz is not found or the fetch operation fails.
  Future<QuizModel> fetchQuizById(String quizId) async {
    try {
      logger.i('Fetching quiz with ID: $quizId from Firestore...');

      // Retrieve the document with the specified quiz ID.
      final docSnapshot =
          await _firestore.collection('quizzes').doc(quizId).get();

      // Check if the document exists in Firestore.
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          logger.i('Successfully fetched quiz with ID: $quizId.');

          // Merge the Firestore data with the quiz ID and return the QuizModel.
          return QuizModel.fromFirestore({
            ...data,
            'quiz_id': docSnapshot.id,
          });
        } else {
          logger.w('Document data is null for quiz ID: $quizId.');
          throw Exception('Document data is null for quiz $quizId');
        }
      } else {
        logger.w('Quiz with ID $quizId not found.');
        throw Exception('Quiz with ID $quizId not found');
      }
    } catch (e, stackTrace) {
      // Log the error and rethrow it as an exception.
      logger.e('Failed to fetch quiz with ID $quizId',
          error: e, stackTrace: stackTrace);
      throw Exception('Failed to fetch quiz with ID $quizId: $e');
    }
  }
}
