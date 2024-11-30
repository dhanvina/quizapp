import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:quizapp/data/data_sources/student_data_source.dart';

import '../../domain/entities/student.dart';
import '../../domain/repository/student_repository.dart';
import '../models/student_model.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class StudentRepositoryImpl implements StudentRepository {
  final StudentDataSource dataSource;

  StudentRepositoryImpl({required this.dataSource});

  // Fetch student by school code and roll number
  @override
  Future<Either<Exception, Student?>> getStudentBySchoolCodeAndRollNumber(
      String schoolCode, String rollNumber) async {
    logger.i(
        'Fetching student with schoolCode: $schoolCode, rollNumber: $rollNumber');

    try {
      // Fetch student from the data source
      final StudentModel? studentModel = await dataSource
          .getStudentBySchoolCodeAndRollNumber(schoolCode, rollNumber);

      if (studentModel != null) {
        logger.i('Student found: ${studentModel.name}');

        // Convert student model to student entity
        final student = Student(
            name: studentModel.name,
            school: studentModel.school,
            roll_number: studentModel.roll_number,
            school_code: studentModel.school_code,
            hasAttemptedLiveQuiz: studentModel.hasAttemptedLiveQuiz,
            quizResults: studentModel.quizResults);

        // Return student wrapped in a Right (success)
        return Right(student);
      } else {
        logger.w(
            'No matching student found for schoolCode: $schoolCode, rollNumber: $rollNumber');

        // Return error in case no student is found (Left)
        return Left(Exception("Login failed: No matching student found"));
      }
    } catch (e, stackTrace) {
      logger.e('Error in StudentRepositoryImpl: $e',
          error: e, stackTrace: stackTrace);

      // Return error wrapped in Left
      return Left(Exception("Login failed: $e"));
    }
  }

// You can add additional methods here, for example:
// @override
// Future<void> updateQuizResult(String studentId, QuizResult quizResult) async {
//   await dataSource.updateQuizResult(studentId, quizResult.toDataModel());
// }
}
