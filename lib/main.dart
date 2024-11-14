// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/data/data_sources/json_data_source.dart';
import 'package:quizapp/data/repositories/question_repository.dart';
import 'package:quizapp/presentation/pages/dashboard.dart'; // Replace with actual dashboard page
import 'package:quizapp/presentation/pages/vedic_math_page.dart'; // Replace with actual Vedic math page
import 'package:quizapp/presentation/state_management/question_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final jsonDataSource = JsonDataSource();

    return ChangeNotifierProvider(
      create: (context) =>
          QuestionProvider(repository: QuestionRepository(jsonDataSource)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        initialRoute: '/',
        routes: {
          '/': (context) => PaperSelectionPage(),
          '/vedic': (context) => VedicMathPage(),
        },
      ),
    );
  }
}
