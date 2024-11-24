// student_repository.dart
import 'package:dartz/dartz.dart';

import '../entities/student.dart';

abstract class StudentRepository {
  Future<Either<Exception, Student?>> getStudentBySchoolCodeAndRollNumber(
      String school_code, String roll_number);
  // Future<void> updateQuizResult(String studentId, QuizResult quizResult);
}
