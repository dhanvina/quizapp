import 'package:dartz/dartz.dart';

import '../entities/student.dart';
import '../repository/student_repository.dart';

class GetStudentById {
  final StudentRepository repository;

  GetStudentById({required this.repository});

  Future<Either<Exception, Student?>> call(
      String school_code, String roll_number) {
    return repository.getStudentBySchoolCodeAndRollNumber(
        school_code, roll_number);
  }
}
