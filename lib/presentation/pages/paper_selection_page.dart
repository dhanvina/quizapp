import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/widgets/paper_title_widget.dart';

import '../state_management/question_provider.dart';
import 'question_page.dart';

class PaperSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.loadPapers(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Practice Paper",
          style: TextStyle(
            fontFamily: 'Rubik',
            color: Color(0xFF0C092A),
            fontWeight: FontWeight.w500,
            fontSize: 23.63,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<QuestionProvider>(
          builder: (context, provider, _) {
            if (provider.papers.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: provider.papers.length,
              itemBuilder: (context, index) {
                final paper = provider.papers[index];
                return ListTile(
                  title: PaperTitleWidget(title: paper.title),
                  onTap: () {
                    provider.selectPaper(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              QuestionPage(quizTimeInMinutes: paper.time)),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
