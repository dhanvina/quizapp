import 'package:dartz/dartz.dart';
import 'package:quizapp/domain/entities/student_login_entity.dart';

import '../../domain/repository/student_login_repository.dart';
import '../data_sources/firestore_student_login_data_source.dart';
import '../models/student_user_model.dart';

class StudentLoginRepositoryImpl implements StudentLoginRepository {
  final FirestoreStudentLoginDataSource dataSource;

  StudentLoginRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, StudentLogin?>> loginStudent(String fullname,
      String rollnumber, String schoolcode, String password) async {
    try {
      final StudentLoginModel? studentLoginModel = await dataSource
          .loginStudent(fullname, rollnumber, schoolcode, password);

      if (studentLoginModel != null) {
        final studentLogin = StudentLogin(
          fullName: studentLoginModel.fullName,
          rollNumber: studentLoginModel.rollNumber,
          schoolCode: studentLoginModel.schoolCode,
          password: studentLoginModel.password,
        );

        return Right(studentLogin);
      } else {
        return Left(Exception("Login failed: No matching student found"));
      }
    } catch (e) {
      return Left(Exception("Login failed: $e"));
    }
  }
}
