import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/data/models/student_user_model.dart';

class FirestoreStudentLoginDataSource {
  final FirebaseFirestore firestore;

  FirestoreStudentLoginDataSource(this.firestore);

  Future<StudentLoginModel?> loginStudent(String fullName, String rollNumber,
      String schoolCode, String password) async {
    try {
      final querySnapshot = await firestore
          .collection('students')
          .where('fullName', isEqualTo: fullName)
          .where('rollNumber', isEqualTo: rollNumber)
          .where('schoolCode', isEqualTo: schoolCode)
          .where('password', isEqualTo: password)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return StudentLoginModel.fromMap(doc);
      } else {
        return null;
      }
    } catch (e) {
      print("Error logging in student: $e");
      return null;
    }
  }
}
