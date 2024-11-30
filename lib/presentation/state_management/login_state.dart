import 'package:logger/logger.dart';

// Create a Logger instance
final Logger logger = Logger();

/// Base class representing different states of the login process.
abstract class LoginState {}

/// Represents the initial state before any login action has occurred.
class LoginInitial extends LoginState {
  LoginInitial() {
    logger.i('Login state initialized.');
  }
}

/// Represents the loading state during an ongoing login operation.
class LoginLoading extends LoginState {
  LoginLoading() {
    logger.i('Login is currently in progress.');
  }
}

/// Represents a successful login state.
/// Contains a success message.
class LoginSuccess extends LoginState {
  final String message;

  /// Constructor for the success state, accepting a success message.
  LoginSuccess(this.message) {
    logger.i('Login successful: $message');
  }
}

/// Represents a failed login state.
/// Contains an error message describing the failure.
class LoginFailure extends LoginState {
  final String error;

  /// Constructor for the failure state, accepting an error message.
  LoginFailure(this.error) {
    logger.e('Login failed: $error');
  }
}
