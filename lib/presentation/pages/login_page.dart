import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/widgets/login_form.dart';

import '../../data/data_sources/firestore_student_login_data_source.dart'; // Import the data source
import '../../data/repositories/student_login_repository_impl.dart';
import '../../domain/use_cases/login_student_use_case.dart';
import '../state_management/login_notifier.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        // Create an instance of FirebaseFirestore (make sure to import the required packages)
        final firestore = FirebaseFirestore.instance;

        // Create an instance of the FirestoreStudentLoginDataSource
        final dataSource = FirestoreStudentLoginDataSource(firestore);

        // Pass the dataSource to StudentLoginRepositoryImpl
        return LoginNotifier(
          loginStudentUseCase:
              LoginStudentUseCase(StudentLoginRepositoryImpl(dataSource)),
        );
      },
      child: Scaffold(
        body: Center(
          child: const LoginForm(),
        ),
      ),
    );
  }
}
