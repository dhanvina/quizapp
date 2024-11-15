import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/data/data_sources/json_data_source.dart';
import 'package:quizapp/presentation/pages/dashboard.dart';
import 'package:quizapp/presentation/state_management/VedicQuestionProvider.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';
import 'package:quizapp/utils/app_router.dart';

import 'data/data_sources/vedic_math_data_source.dart';
import 'data/repositories/question_repository.dart';
import 'data/repositories/vedic_math_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    final jsonDataSource = JsonDataSource();
    final vedicMathDataSource = VedicMathDataSource();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuestionProvider(
            repository: QuestionRepository(jsonDataSource),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => VedicQuestionProvider(
            VedicMathRepository(vedicMathDataSource),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        home: PaperSelectionPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
