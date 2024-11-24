import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore dependency
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data_sources/student_data_source.dart'; // Import this for data source
import '../../data/repositories/student_repository_impl.dart';
import '../state_management/login_notifier.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(
        studentRepository: StudentRepositoryImpl(
          dataSource: StudentDataSource(firestore: FirebaseFirestore.instance),
        ),
      ),
      child: const LoginForm(),
    );
  }
}
