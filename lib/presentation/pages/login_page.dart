import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore dependency
import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Import logger package
import 'package:provider/provider.dart';

import '../../data/data_sources/student_data_source.dart'; // Import this for data source
import '../../data/repositories/student_repository_impl.dart';
import '../state_management/login_notifier.dart';
import '../widgets/login_form.dart';

// Initialize the logger
final Logger logger = Logger();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Log the event of loading the LoginPage
    logger.i("Loading LoginPage");

    return ChangeNotifierProvider(
      create: (_) {
        // Log the event of creating the LoginNotifier
        logger.i("Creating LoginNotifier with student repository");

        // Creating the LoginNotifier and passing the student repository with Firestore data source
        return LoginNotifier(
          studentRepository: StudentRepositoryImpl(
            dataSource: StudentDataSource(FirebaseFirestore.instance),
          ),
        );
      },
      child: const LoginForm(),
    );
  }
}
