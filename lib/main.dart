import 'package:flutter/material.dart';
import 'package:quizapp/completion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SuccessScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
