import 'package:dartz/dartz.dart';

import '../entities/student_login_entity.dart';
import '../repository/student_login_repository.dart';

class LoginStudentUseCase {
  final StudentLoginRepository repository;
  LoginStudentUseCase(this.repository);

  Future<Either<Exception, StudentLogin?>> execute(String fullName,
      String rollNumber, String schoolCode, String password) async {
    return await repository.loginStudent(
        fullName, rollNumber, schoolCode, password);
  }
}
