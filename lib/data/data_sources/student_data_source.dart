import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:quizapp/data/models/student_model.dart';

/// Data source class for handling student-related operations in Firestore.
class StudentDataSource {
  final FirebaseFirestore
      _firestore; // Firestore instance for database interactions.
  final Logger logger; // Logger instance for structured logging.

  /// Constructor to initialize the Firestore instance and logger.
  ///
  /// Parameters:
  /// - `firestore`: The Firestore instance used for database operations.
  StudentDataSource(this._firestore) : logger = Logger();

  /// Fetches a student document from Firestore based on school code and roll number.
  ///
  /// Parameters:
  /// - `school_code`: The code of the school to search within.
  /// - `roll_number`: The roll number of the student to find.
  ///
  /// Returns:
  /// - A [StudentModel] object if the student exists.
  /// - `null` if no matching student is found.
  Future<StudentModel?> getStudentBySchoolCodeAndRollNumber(
      String schoolCode, String rollNumber) async {
    try {
      // Log the parameters being used for the query.
      logger.i(
          'Fetching student from Firestore with school_code: $schoolCode, roll_number: $rollNumber');

      // Query Firestore to find a student matching the school code and roll number.
      final querySnapshot = await _firestore
          .collection('students') // Collection name in Firestore.
          .where('school_code', isEqualTo: schoolCode) // Filter by school code.
          .where('roll_number', isEqualTo: rollNumber) // Filter by roll number.
          .get();

      // Check if the query returned any documents.
      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the first matching document.
        final doc = querySnapshot.docs.first.data();
        logger.d('Found student: ${doc['name']}'); // Log the student's name.

        // Convert the document data into a StudentModel and return it.
        return StudentModel.fromFirestore(doc);
      } else {
        // Log a warning if no student matches the query.
        logger.w(
            'No student found in Firestore with school_code: $schoolCode, roll_number: $rollNumber');
        return null;
      }
    } catch (e, stackTrace) {
      // Log the error and return null in case of an exception.
      logger.e("Error fetching student from Firestore",
          error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> updateQuizResults(
    String schoolCode,
    String rollNumber,
    String quizId,
    int score,
    bool isLive,
    DateTime timestamp,
  ) async {
    try {
      // Explicitly log the values of schoolCode and rollNumber
      logger.i('Starting updateQuizResults');
      logger.i('Received schoolCode: $schoolCode');
      logger.i('Received rollNumber: $rollNumber');
      logger.i('Received isLive: $isLive');

      // Check if the quiz is live
      if (!isLive) {
        logger.w('Quiz is not live. Skipping update.');
        return; // Exit early if the quiz is not live
      }

      // Query to find the student document
      final querySnapshot = await _firestore
          .collection('students')
          .where('school_code', isEqualTo: schoolCode)
          .where('roll_number', isEqualTo: rollNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final studentDoc = querySnapshot.docs.first;

        // Prepare new quiz result data
        final newQuizResult = {
          'quiz_id': quizId,
          'score': score,
          'timestamp': Timestamp.fromDate(timestamp),
        };

        // Update the `quiz_results` array in the document
        await studentDoc.reference.update({
          'quiz_results': FieldValue.arrayUnion([newQuizResult]),
        });

        logger.d('Successfully updated quiz results for student');
      } else {
        logger.w(
            'No matching student document found in the "students" collection for schoolCode: $schoolCode, rollNumber: $rollNumber');
      }
    } catch (e, stackTrace) {
      logger.e('Error updating quiz results', error: e, stackTrace: stackTrace);
      rethrow; // Re-throw the exception for the caller to handle
    }
  }
}
