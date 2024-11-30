import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../entities/student.dart';
import '../repository/student_repository.dart';

// Create a Logger instance
final Logger logger = Logger();

// Use case class to fetch a student by school code and roll number
class GetStudentById {
  final StudentRepository repository;

  // Constructor to initialize the repository
  GetStudentById({required this.repository});

  /// Executes the use case to get a student by their school code and roll number.
  /// Logs the flow of execution and any potential errors.
  Future<Either<Exception, Student?>> call(
      String school_code, String roll_number) async {
    try {
      // Log the start of the method execution
      logger.i(
          'Starting GetStudentById use case: Fetching student with school_code: $school_code, roll_number: $roll_number');

      // Call the repository method to fetch the student
      final result = await repository.getStudentBySchoolCodeAndRollNumber(
          school_code, roll_number);

      // Log the result of the operation
      result.fold(
        (exception) {
          // Log if there was an error fetching the student
          logger.e(
              'Error fetching student with school_code: $school_code, roll_number: $roll_number. Error: $exception');
        },
        (student) {
          // Log the successful retrieval of the student
          if (student != null) {
            logger.i('Successfully fetched student: ${student.name}');
          } else {
            logger.w(
                'No student found with school_code: $school_code, roll_number: $roll_number');
          }
        },
      );

      // Return the result (either exception or student)
      return result;
    } catch (e) {
      // Log any unexpected errors
      logger.e('Error occurred in GetStudentById use case: $e');
      return Left(Exception("Error occurred: $e"));
    }
  }
}
