import 'package:quizapp/domain/entities/Student_Login_Entity.dart';

abstract class StudentLoginRepository {
  // Logs the student with fullname, rollnumber, schoolcode and password
  Future<StudentLogin?> loginStudent(
      String fullName, String rollNumber, String schoolCode, String password);
}
