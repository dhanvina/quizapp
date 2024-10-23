// lib/presentation/state_management/login_state.dart

import '../../../domain/entities/student_login_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final StudentLogin student;
  final String message;

  LoginSuccess(this.student, this.message);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
