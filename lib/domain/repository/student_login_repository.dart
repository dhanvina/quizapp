import 'package:dartz/dartz.dart';
import 'package:quizapp/domain/entities/student_login_entity.dart';

abstract class StudentLoginRepository {
  // Logs the student with fullname, rollnumber, schoolcode and password
  Future<Either<Exception, StudentLogin?>> loginStudent(
      String fullName, String rollNumber, String schoolCode, String password);
}
