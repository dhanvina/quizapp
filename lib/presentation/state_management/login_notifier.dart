import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/student.dart';
import '../../domain/repository/student_repository.dart';
import '../state_management/login_state.dart';

// Create a Logger instance
final Logger logger = Logger();

class LoginNotifier extends ChangeNotifier {
  final StudentRepository studentRepository;

  // Constructor to initialize the repository
  LoginNotifier({required this.studentRepository});

  LoginState _state = LoginInitial();
  LoginState get state => _state;

  Student? _loggedInStudent; // Holds the logged-in student data
  Student? get loggedInStudent => _loggedInStudent;

  /// Handles the login functionality for a student.
  /// Validates input, checks credentials, and manages login state.
  Future<void> login(
      String fullName,
      String rollNumber,   // Correct the variable name here
      String schoolCode,   // Correct the variable name here
      String password,
      BuildContext context,
      ) async {
    // Validate inputs
    if (fullName.isEmpty ||
        rollNumber.isEmpty ||  // Correct the variable name here
        schoolCode.isEmpty ||  // Correct the variable name here
        password.isEmpty) {
      logger.w('Validation failed: One or more fields are empty.');
      _state = LoginFailure("All fields are required.");
      notifyListeners();
      return;
    }

    try {
      // Update state to loading and notify listeners
      _state = LoginLoading();
      notifyListeners();
      logger.i(
          'Login initiated for Roll Number: $rollNumber, School Code: $schoolCode'
      );

      // Fetch student details from the repository
      final Either<Exception, Student?> result = await studentRepository
          .getStudentBySchoolCodeAndRollNumber(schoolCode, rollNumber);

      // Handle the repository result
      result.fold(
            (error) {
          // Log the error and update the state
          logger.e('Error fetching student: ${error.toString()}');
          _state = LoginFailure("An error occurred: ${error.toString()}");
          notifyListeners();
        },
            (student) async {
          if (student == null) {
            // Log if no matching student is found
            logger.w(
                'No matching student found for Roll Number: $rollNumber, School Code: $schoolCode');
            _state = LoginFailure("Student not found.");
          } else if (student.roll_number != rollNumber ||  // Fix variable name here
              student.school_code != schoolCode) {  // Fix variable name here
            // Log if credentials don't match
            logger.w('Invalid credentials provided.');
            _state = LoginFailure("Invalid credentials. Please check your details.");
          } else {
            // Log successful login
            logger.i('Login successful for student: ${student.name}');
            _loggedInStudent = student;
            _state = LoginSuccess("Login successful! Welcome, ${student.name}.");

            // Save logged-in student details to SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('flutter.rollNumber', student.roll_number);
            await prefs.setString('flutter.schoolCode', student.school_code);
            logger.i('Student data saved to SharedPreferences.');

            // Navigate to the home page
            Navigator.pushReplacementNamed(context, '/home');
          }

          notifyListeners();
        },
      );
    } catch (e) {
      // Log unexpected errors and update state
      logger.e('Unexpected error during login: $e');
      _state = LoginFailure("An error occurred: ${e.toString()}");
      notifyListeners();
    }
  }
}
