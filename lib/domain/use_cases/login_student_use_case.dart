import '../entities/Student_Login_Entity.dart';
import '../repository/student_login_repository.dart';

class LoginStudentUseCase {
  final StudentLoginRepository repository;
  LoginStudentUseCase(this.repository);

  Future<StudentLogin?> execute(String fullName, String rollNumber,
      String schoolCode, String password) async {
    return await repository.loginStudent(
        fullName, rollNumber, schoolCode, password);
  }
}
