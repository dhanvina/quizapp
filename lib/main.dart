import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/data/data_sources/json_data_source.dart';
import 'package:quizapp/presentation/pages/login_page.dart';
import 'package:quizapp/presentation/pages/dashboard.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';
import 'package:quizapp/data/repositories/question_repository.dart';
import 'package:quizapp/utils/app_router.dart';

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
    final jsonDataSource = JsonDataSource();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuestionProvider(
            repository: QuestionRepository(jsonDataSource),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Login',
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/paperSelection': (context) => PaperSelectionPage(), // Route for the paper list page
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
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/paperSelection');
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Show a loading indicator while navigating
      ),
    );
  }
}
