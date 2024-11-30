import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../entities/student.dart';

// Initialize the logger instance for logging
final Logger logger = Logger();

// Abstract class for StudentRepository which defines operations related to fetching and updating student data.
abstract class StudentRepository {
  /// Fetches a student by their school code and roll number.
  /// Logs important information like the school code and roll number.
  /// Returns an Either type to handle success (Right) or failure (Left) with an exception.
  Future<Either<Exception, Student?>> getStudentBySchoolCodeAndRollNumber(
      String school_code, String roll_number);

// Future<void> updateQuizResult(String studentId, QuizResult quizResult);
}
