// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:quizapp/presentation/pages/login_page.dart';

// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Student Login',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const LoginPage(),
//         '/home': (context) => const HomePage(), // Define your HomePage widget
//       },
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: const Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/data/data_sources/json_data_source.dart';
import 'package:quizapp/presentation/pages/dashboard.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';
import 'package:quizapp/utils/app_router.dart';

import 'data/repositories/question_repository.dart';

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
        title: 'Quiz App',
        home: PaperSelectionPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
