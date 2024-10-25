import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/domain/entities/student_login_entity.dart';

import '../../domain/use_cases/login_student_use_case.dart';
import 'login_state.dart';

class LoginNotifier extends ChangeNotifier {
  final LoginStudentUseCase loginStudentUseCase;

  LoginNotifier({required this.loginStudentUseCase});

  LoginState _state = LoginInitial();
  LoginState get state => _state;

  Future<void> login(String fullName, String rollNumber, String schoolCode,
      String password, BuildContext context) async {
    _state = LoginLoading();
    notifyListeners();

    Either<Exception, StudentLogin?> result = await loginStudentUseCase.execute(
        fullName, rollNumber, schoolCode, password);

    result.fold(
      (exception) {
        _state = LoginFailure(exception.toString());
      },
      (studentLogin) {
        if (studentLogin != null) {
          _state = LoginSuccess(studentLogin,
              'Login Successful for ${studentLogin.fullName}'); // Ensure this is the correct StudentLogin type
          Navigator.pushReplacementNamed(
            context,
            '/dashboard',
            arguments: studentLogin.fullName,
          );
        } else {
          _state = LoginFailure('Invalid login credentials');
        }
      },
    );
    notifyListeners();
  }
}
