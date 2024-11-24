import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/data/models/student_model.dart';

class StudentDataSource {
  final FirebaseFirestore firestore;

  StudentDataSource({required this.firestore});

  // Fetch student based on school_code and roll_number
  Future<StudentModel?> getStudentBySchoolCodeAndRollNumber(
      String school_code, String roll_number) async {
    try {
      print(
          'Fetching student from Firestore with school_code: $school_code, roll_number: $roll_number');

      // Query Firestore by school_code (String) and roll_number (String)
      final querySnapshot = await firestore
          .collection('students')
          .where('school_code',
              isEqualTo: school_code) // Query by school_code (String)
          .where('roll_number',
              isEqualTo: roll_number) // Query by roll_number (String)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first.data() as Map<String, dynamic>;
        print('Found student: ${doc['name']}'); // Debugging line
        return StudentModel.fromFirestore(doc);
      } else {
        print(
            'No student found in Firestore with school_code: $school_code, roll_number: $roll_number');
        return null;
      }
    } catch (e) {
      print("Error fetching student from Firestore: $e");
      return null;
    }
  }
}
