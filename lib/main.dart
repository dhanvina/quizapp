import 'package:flutter/material.dart';
import 'package:quizapp/test_prepartion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPreparationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
