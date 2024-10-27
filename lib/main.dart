import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/paper_selection_page.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart'; // The QuestionProvider created for handling questions
import 'package:quizapp/utils/app_router.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return ChangeNotifierProvider(
      create: (context) => QuestionProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        theme: ThemeData(primarySwatch: Colors.green),
        home: PaperSelectionPage(),
      ),
    );
  }
}
