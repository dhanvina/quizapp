// lib/presentation/pages/vedic_math_page.dart
import 'package:flutter/material.dart';
import '../../data/models/vedic_math_model.dart';
import '../../data/data_sources/vedic_math_data_source.dart';
import '../widgets/vedic_text.dart';

class VedicMathPage extends StatefulWidget {
  @override
  _VedicMathPageState createState() => _VedicMathPageState();
}

class _VedicMathPageState extends State<VedicMathPage> {
  late Future<VedicMathPracticePaper> _practicePaperFuture;
  final Map<int, num> _userAnswers = {};  // Map to store user answers
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _practicePaperFuture = VedicMathDataSource().fetchPracticePaper();
  }

  void _calculateScore(VedicMathPracticePaper practicePaper) {
    int score = 0;
    for (int i = 0; i < practicePaper.questions.length; i++) {
      final correctAnswer = practicePaper.questions[i].answer;
      final userAnswer = _userAnswers[i];

      if (userAnswer != null && userAnswer == correctAnswer) {
        score += 1;
      }
    }
    setState(() {
      _score = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vedic Math Practice'),
      ),
      body: FutureBuilder<VedicMathPracticePaper>(
        future: _practicePaperFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final practicePaper = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: practicePaper.questions.length,
                  itemBuilder: (context, index) {
                    final question = practicePaper.questions[index];
                    return VedicText(
                      question: question,
                      onAnswerChanged: (answer) {
                        setState(() {
                          _userAnswers[index] = num.tryParse(answer) ?? 0;
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _calculateScore(practicePaper);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Score"),
                        content: Text("Your score: $_score / ${practicePaper.questions.length}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
