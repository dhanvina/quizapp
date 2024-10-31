import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/question_provider.dart';
import 'question_page.dart';

class PaperSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.loadPapers(context);

    return Scaffold(
      backgroundColor: Constants.green,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "Choose Practice Paper",
            style: TextStyle(
              fontFamily: 'Rubik',
              color: Color(0xFF0C092A),
              fontWeight: FontWeight.w500,
              fontSize: 23.63,
            ),
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

            return Center(
              // Center the Container
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.offWhite,
                  borderRadius: BorderRadius.circular(20), // Rounded edges
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 3), // Position of the shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width *
                    0.5, // Adjust width as needed
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  // Making the ListView scrollable
                  children: provider.papers.map(
                    (paper) {
                      return Center(
                        child: Container(
                          color: Constants.offWhite,
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Display the paper title aligned to the left
                              Expanded(
                                child: Text(
                                  paper.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Display the "Try" button in the same row
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  backgroundColor: Constants.offWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadowColor: Constants.black,
                                  elevation: 4,
                                ),
                                onPressed: () {
                                  provider.selectPaper(
                                      provider.papers.indexOf(paper));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionPage(
                                          quizTimeInMinutes: paper.time),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Try",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
