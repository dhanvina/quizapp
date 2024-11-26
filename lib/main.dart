import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/data/data_sources/json_data_source.dart';
import 'package:quizapp/data/data_sources/quiz_data_source.dart'; // Ensure this import
import 'package:quizapp/data/repositories/question_repository.dart';
import 'package:quizapp/domain/use_cases/firestore_fetch_quiz.dart';
import 'package:quizapp/presentation/pages/dashboard.dart';
import 'package:quizapp/presentation/pages/login_page.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';
import 'package:quizapp/presentation/state_management/quiz_provider.dart';
import 'package:quizapp/utils/app_router.dart';

import 'data/repositories/firestore_quiz_repository_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    // Create instances of the required data sources and repositories
    final jsonDataSource = JsonDataSource();
    final quizDataSource = QuizDataSource(FirebaseFirestore
        .instance); // Replace with your actual QuizDataSource implementation
    final quizRepository =
        QuizRepositoryImpl(quizDataSource); // Instantiate QuizRepositoryImpl
    final getQuizzesUseCase =
        GetQuizzesUseCase(quizRepository); // Pass it to the use case

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuestionProvider(
            repository: QuestionRepository(jsonDataSource),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              QuizProvider(getQuizzesUseCase), // Pass GetQuizzesUseCase here
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
    // Automatically navigate to PaperSelectionPage without showing a success message.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/paperSelection');
      print('Navigation to PaperSelectionPage successful');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child:
            CircularProgressIndicator(), // Show a loading indicator while navigating
      ),
    );
  }
}
