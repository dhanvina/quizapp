import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:quizapp/data/models/student_model.dart';

/// Data source class for handling student-related operations in Firestore.
class StudentDataSource {
  final FirebaseFirestore
      firestore; // Firestore instance for database interactions.
  final Logger logger; // Logger instance for structured logging.

  /// Constructor to initialize the Firestore instance and logger.
  ///
  /// Parameters:
  /// - `firestore`: The Firestore instance used for database operations.
  StudentDataSource({required this.firestore}) : logger = Logger();

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
      String school_code, String roll_number) async {
    try {
      // Log the parameters being used for the query.
      logger.i(
          'Fetching student from Firestore with school_code: $school_code, roll_number: $roll_number');

      // Query Firestore to find a student matching the school code and roll number.
      final querySnapshot = await firestore
          .collection('students') // Collection name in Firestore.
          .where('school_code',
              isEqualTo: school_code) // Filter by school code.
          .where('roll_number',
              isEqualTo: roll_number) // Filter by roll number.
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
            'No student found in Firestore with school_code: $school_code, roll_number: $roll_number');
        return null;
      }
    } catch (e, stackTrace) {
      // Log the error and return null in case of an exception.
      logger.e("Error fetching student from Firestore",
          error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
