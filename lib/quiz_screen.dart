import 'package:flutter/material.dart';
import 'package:quizapp/completion_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size for responsiveness

    return Scaffold(
      body: Stack(
        children: [
          // Background image that fills the screen
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/quiz_app_background.png'),
                fit: BoxFit.fill, // Ensures the image covers the screen fully
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Total duration UI - with white background taking only as much space as the text needs
                GestureDetector(
                  onTap: () {
                    // Navigate to SuccessScreen when the timer is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Text(
                      'Total duration - 10:00',
                      style: TextStyle(
                        fontSize: size.width * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // School name
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Mount Carmel English School',
                    style: TextStyle(
                      fontSize: size.width * 0.04, // Responsive font size
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic, // Make it italic as required
                    ),
                  ),
                ),

                // Main Quiz container
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.09,
                      vertical: size.height * 0.05),
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA2D12C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Question 1 text on top of circles and timer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // "Question 1" text above circles
                          Text(
                            'Question 1',
                            style: TextStyle(
                              fontSize: size.width * 0.05, // Adjust font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Timer 00:29 with exact styling as per the image you provided
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                                vertical: size.width * 0.01),
                            decoration: BoxDecoration(
                              color: Color(0xFFA2D12C), // Green background matching the quiz container
                              borderRadius: BorderRadius.circular(30), // Rounded corners
                              border: Border.all(color: Colors.red, width: 3), // Red border
                            ),
                            child: Text(
                              '00:29',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: size.width * 0.05, // Adjust font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.01),

                      // Circles in 2 rows (10 in each row)
                      Column(
                        children: [
                          // First row of 10 circles
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(10, (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  Icons.circle,
                                  color: index == 0
                                      ? Colors.green
                                      : Colors.grey.shade400,
                                  size: size.width * 0.04, // Adjust circle size
                                ),
                              );
                            }),
                          ),

                          SizedBox(height: 10), // Spacing between two rows of circles

                          // Second row of 10 circles
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(10, (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  Icons.circle,
                                  color: index == 0
                                      ? Colors.green
                                      : Colors.grey.shade400,
                                  size: size.width * 0.04, // Adjust circle size
                                ),
                              );
                            }),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Question prompt
                      Container(
                        padding: EdgeInsets.all(size.width * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'solve this:',
                              style: TextStyle(
                                fontSize: size.width * 0.05, // Responsive font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              '2\n-2\n+4\n-3',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.045, // Adjust text size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.03), // Adjust spacing based on design

                      // Answer choices (buttons)
                      GridView.count(
                        crossAxisCount: 2, // Display buttons in 2 columns
                        crossAxisSpacing: size.width * 0.04, // Horizontal spacing
                        mainAxisSpacing: size.height * 0.02, // Vertical spacing
                        shrinkWrap: true, // Make grid non-scrollable
                        physics: NeverScrollableScrollPhysics(), // Disable scrolling
                        children: [
                          QuizOptionButton(label: '1', size: size),
                          QuizOptionButton(label: '2', size: size),
                          QuizOptionButton(label: '0', size: size),
                          QuizOptionButton(label: '3', size: size),
                        ],
                      ),

                      SizedBox(height: size.height * 0.02), // Add spacing at the bottom

                      // Abacus image below the options with its actual size
                      Image.asset(
                        'assets/quiz_app_abacus.png',
                        fit: BoxFit.contain, // Ensure the image takes its actual size
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Answer Buttons
class QuizOptionButton extends StatelessWidget {
  final String label;
  final Size size;

  const QuizOptionButton({required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your logic for button press here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: label == '1' ? Colors.green : Colors.black, // Change button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03, // Adjust padding based on size
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: size.width * 0.045, // Adjust font size to match the design
          color: Colors.white,
        ),
      ),
    );
  }
}
