import 'package:logger/logger.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class StudentLoginModel {
  final String fullName;
  final String rollNumber;
  final String schoolCode;
  final String password;

  // Constructor for StudentLoginModel
  StudentLoginModel({
    required this.fullName,
    required this.rollNumber,
    required this.schoolCode,
    required this.password,
  });

  // Method to convert StudentLoginModel to a map for easier storage (e.g., Firestore, API)
  Map<String, dynamic> toMap() {
    logger.i('Converting StudentLoginModel to Map: $this');

    // Log the mapping process and data being converted
    logger.d(
        'StudentLoginModel data: fullName=$fullName, rollNumber=$rollNumber, schoolCode=$schoolCode');

    return {
      'fullName': fullName,
      'rollNumber': rollNumber,
      'schoolCode': schoolCode,
      'password': password,
    };
  }

  // Factory method to create a StudentLoginModel from a map
  factory StudentLoginModel.fromMap(Map<String, dynamic> map) {
    logger.i('Creating StudentLoginModel from Map: $map');

    try {
      // Log the map data being processed
      logger.d('StudentLoginModel map: $map');

      return StudentLoginModel(
        fullName: map['fullName'] ?? '',
        rollNumber: map['rollNumber'] ?? '',
        schoolCode: map['schoolCode'] ?? '',
        password: map['password'] ?? '',
      );
    } catch (e, stackTrace) {
      // Log any errors during the conversion process
      logger.e('Error creating StudentLoginModel from Map',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the error to be handled further up the stack
    }
  }
}
