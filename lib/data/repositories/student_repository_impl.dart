import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:quizapp/data/data_sources/student_data_source.dart';

import '../../domain/entities/quiz_result.dart';
import '../../domain/entities/student.dart';
import '../../domain/repository/student_repository.dart';
import '../models/student_model.dart';

final Logger logger = Logger();

class StudentRepositoryImpl implements StudentRepository {
  final StudentDataSource dataSource;

  StudentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exception, Student?>> getStudentBySchoolCodeAndRollNumber(
      String schoolCode, String rollNumber) async {
    logger.i(
        'Fetching student with schoolCode: $schoolCode, rollNumber: $rollNumber');

    try {
      final StudentModel? studentModel = await dataSource
          .getStudentBySchoolCodeAndRollNumber(schoolCode, rollNumber);

      if (studentModel != null) {
        logger.i('Student found: ${studentModel.name}');

        final student = Student(
            name: studentModel.name,
            school: studentModel.school,
            roll_number: studentModel.roll_number,
            school_code: studentModel.school_code,
            hasAttemptedLiveQuiz: studentModel.hasAttemptedLiveQuiz,
            quizResults: studentModel.quizResults);

        return Right(student);
      } else {
        logger.w(
            'No matching student found for schoolCode: $schoolCode, rollNumber: $rollNumber');
        return Left(Exception("Login failed: No matching student found"));
      }
    } catch (e, stackTrace) {
      logger.e('Error in StudentRepositoryImpl: $e',
          error: e, stackTrace: stackTrace);
      return Left(Exception("Login failed: $e"));
    }
  }

  @override
  Future<Either<Exception, void>> updateQuizResults(
      String schoolCode, String rollNumber, QuizResult quizResult) async {
    try {
      await dataSource.updateQuizResults(
        schoolCode,
        rollNumber,
        quizResult.quizId,
        quizResult.score,
        quizResult.isLive,
      );

      return Right(null); // Success
    } catch (e, stackTrace) {
      logger.e('Error in StudentRepositoryImpl: $e',
          error: e, stackTrace: stackTrace);
      return Left(Exception('Error updating quiz results: $e'));
    }
  }
}