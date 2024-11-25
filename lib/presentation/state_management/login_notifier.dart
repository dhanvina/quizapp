import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/student.dart';
import '../../domain/repository/student_repository.dart';
import '../state_management/login_state.dart';

class LoginNotifier extends ChangeNotifier {
  final StudentRepository studentRepository;

  LoginNotifier({required this.studentRepository});

  LoginState _state = LoginInitial();
  LoginState get state => _state;

  Student? _loggedInStudent; // Hold the logged-in student data
  Student? get loggedInStudent => _loggedInStudent;

  void login(
    String fullName,
    String roll_number,
    String school_code,
    String password,
    BuildContext context,
  ) async {
    // Validation
    if (fullName.isEmpty ||
        roll_number.isEmpty ||
        school_code.isEmpty ||
        password.isEmpty) {
      _state = LoginFailure("All fields are required.");
      notifyListeners();
      return;
    }

    try {
      _state = LoginLoading();
      notifyListeners();

      // Debug: Check if validation passed
      print('Validation passed, attempting to fetch student...');

      // Fetch student details by school code and roll number
      final Either<Exception, Student?> result = await studentRepository
          .getStudentBySchoolCodeAndRollNumber(school_code, roll_number);

      // Debug: Log the result of the student fetch
      print('Result from repository: $result');

      result.fold(
        (error) {
          // Debug: Log the error
          print('Error occurred: ${error.toString()}');
          _state = LoginFailure("An error occurred: ${error.toString()}");
          notifyListeners();
        },
        (student) async {
          // Debug: Check what the student data is
          print('Fetched student: $student');

          if (student == null) {
            // Debug: Log if student is null
            print('No matching student found');
            _state = LoginFailure("Student not found.");
          } else if (student.roll_number != roll_number ||
              student.school_code != school_code) {
            // Debug: Log if credentials don't match
            print(
                'Invalid credentials. Expected Roll Number: ${student.roll_number}, School Code: ${student.school}');
            _state =
                LoginFailure("Invalid credentials. Please check your details.");
          } else {
            // Debug: Log successful login
            print('Login successful! Welcome, ${student.name}');
            _loggedInStudent = student;
            print(
                'Logged in student: ${_loggedInStudent?.name ?? 'No student data'}');
            _state =
                LoginSuccess("Login successful! Welcome, ${student.name}.");

            // Save to Shared Preferences
            final prefs = await SharedPreferences.getInstance();
            final studentJson = jsonEncode(
                student.toJson()); // Assuming Student has a toJson method
            await prefs.setString('loggedInStudent', studentJson);

            // Navigate to home page after successful login
            Navigator.pushReplacementNamed(context, '/home');
          }
          notifyListeners();
        },
      );
    } catch (e) {
      // Debug: Log any unexpected errors
      print('An unexpected error occurred: $e');
      _state = LoginFailure("An error occurred: ${e.toString()}");
      notifyListeners();
    }
  }
}
