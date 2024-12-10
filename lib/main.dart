import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/data/data_sources/quiz_data_source.dart';
import 'package:quizapp/domain/use_cases/firestore_fetch_quiz.dart';
import 'package:quizapp/presentation/pages/dashboard.dart';
import 'package:quizapp/presentation/pages/login_page.dart';
import 'package:quizapp/presentation/state_management/quiz_provider.dart';
import 'package:quizapp/utils/app_router.dart';

import 'data/data_sources/student_data_source.dart';
import 'data/repositories/firestore_quiz_repository_impl.dart';
import 'data/repositories/student_repository_impl.dart';
import 'domain/use_cases/update_quiz_results_use_case.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that all bindings are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase has already been initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  log('Firebase initialized successfully'); // Log Firebase initialization status

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(); // Initialize the app router

    // Create instances of the required data sources and repositories
    final quizDataSource = QuizDataSource(FirebaseFirestore.instance);
    log('QuizDataSource initialized'); // Log the initialization of QuizDataSource

    final quizRepository = QuizRepositoryImpl(quizDataSource);
    log('QuizRepositoryImpl initialized'); // Log the initialization of QuizRepositoryImpl

    final getQuizzesUseCase = GetQuizzesUseCase(quizRepository);
    log('GetQuizzesUseCase initialized'); // Log the initialization of GetQuizzesUseCase

    // Corrected instantiation of StudentDataSource
    final studentDataSource = StudentDataSource(FirebaseFirestore.instance);
    final studentRepository =
        StudentRepositoryImpl(dataSource: studentDataSource);
    final getStudentUseCase = UpdateQuizResultsUseCase(studentRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizProvider(
              quizRepository: quizRepository,
              getQuizzesUseCase: getQuizzesUseCase,
              updateQuizResultsUseCase:
                  getStudentUseCase), // Pass GetQuizzesUseCase here
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Login',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/paperSelection': (context) => PaperSelectionPage(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a post-frame callback to automatically navigate to PaperSelectionPage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/paperSelection');
      log('Navigated to PaperSelectionPage'); // Log navigation success
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
