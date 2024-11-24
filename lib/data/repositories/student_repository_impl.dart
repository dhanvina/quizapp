import 'package:dartz/dartz.dart';
import 'package:quizapp/data/data_sources/student_data_source.dart';

import '../../domain/entities/student.dart';
import '../../domain/repository/student_repository.dart';
import '../models/student_model.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentDataSource dataSource;

  StudentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exception, Student?>> getStudentBySchoolCodeAndRollNumber(
      String schoolCode, String rollNumber) async {
    try {
      print(
          'Fetching student with schoolCode: $schoolCode, rollNumber: $rollNumber');

      final StudentModel? studentModel = await dataSource
          .getStudentBySchoolCodeAndRollNumber(schoolCode, rollNumber);

      if (studentModel != null) {
        print('Student found: ${studentModel.name}');
        final student = Student(
            name: studentModel.name,
            school: studentModel.school,
            roll_number: studentModel.roll_number,
            school_code: studentModel.school_code,
            hasAttemptedLiveQuiz: studentModel.hasAttemptedLiveQuiz,
            quizResults: studentModel.quizResults);

        return Right(student);
      } else {
        print(
            'No matching student found for schoolCode: $schoolCode, rollNumber: $rollNumber');
        return Left(Exception("Login failed: No matching student found"));
      }
    } catch (e) {
      print('Error in StudentRepositoryImpl: $e');
      return Left(Exception("Login failed: $e"));
    }
  }

  // @override
  // Future<void> updateQuizResult(String studentId, QuizResult quizResult) async {
  //   await dataSource.updateQuizResult(studentId, quizResult.toDataModel());
  // }
}
