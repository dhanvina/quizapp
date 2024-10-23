// data/repositories/student_login_repository_impl.dart

import 'package:dartz/dartz.dart'; // For using Either type (for handling errors)
import 'package:quizapp/domain/entities/student_login_entity.dart'; // Importing the domain entity

import '../../domain/repository/student_login_repository.dart'; // Importing the domain repository interface
import '../data_sources/firestore_student_login_data_source.dart'; // Importing the data source
import '../models/student_user_model.dart'; // Importing the data model

class StudentLoginRepositoryImpl implements StudentLoginRepository {
  final FirestoreStudentLoginDataSource dataSource;

  // Constructor to inject the data source
  StudentLoginRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, StudentLogin?>> loginStudent(String fullname,
      String rollnumber, String schoolcode, String password) async {
    try {
      // Use the data source to fetch the student login information
      final StudentLoginModel? studentLoginModel = await dataSource
          .loginStudent(fullname, rollnumber, schoolcode, password);

      // Check if the login was successful
      if (studentLoginModel != null) {
        // Convert the data model (StudentLoginModel) to a domain entity (StudentLogin)
        final studentLogin = StudentLogin(
          fullName: studentLoginModel.fullName,
          rollNumber: studentLoginModel.rollNumber,
          schoolCode: studentLoginModel.schoolCode,
          password: studentLoginModel.password,
        );

        return Right(
            studentLogin); // Return success (Right) with the domain entity
      } else {
        return Left(Exception("Login failed: No matching student found"));
      }
    } catch (e) {
      // Return failure (Left) if an exception occurs
      return Left(Exception("Login failed: $e"));
    }
  }
}
