import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size; // Get screen size for responsiveness

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/success_background.png'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              // School name and duration
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      'Mount Carmel English School',
                      style: TextStyle(
                        fontSize: size.width * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total duration - 10:00',
                      style: TextStyle(
                          fontSize: size.width * 0.03), // Responsive font size
                    ),
                  ],
                ),
              ),

              // Main Quiz container
              Expanded(
                child: Container(
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
                      // Question progress indicators and timer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Progress indicators (create a row of dots)
                          Row(
                            children: List.generate(10, (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  Icons.circle,
                                  color: index == 0
                                      ? Colors.green
                                      : Colors.grey.shade400,
                                  size: size.width *
                                      0.025, // Responsive icon size
                                ),
                              );
                            }),
                          ),
                          // Timer
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                                vertical: size.width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '00:29',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Question text
                      Text(
                        'Question 1',
                        style: TextStyle(
                          fontSize: size.width * 0.06, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
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
                                fontSize:
                                    size.width * 0.05, // Responsive font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              '2\n-2\n+4\n-3',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16, // Responsive font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      // Answer choices (buttons)
                      GridView.count(
                        crossAxisCount: size.width > 400
                            ? 4
                            : 2, // Adjust based on screen width
                        crossAxisSpacing: 50,
                        mainAxisSpacing: 50,
                        shrinkWrap: true,
                        children: [
                          QuizOptionButton(label: '1'),
                          QuizOptionButton(label: '2'),
                          QuizOptionButton(label: '0'),
                          QuizOptionButton(label: '3'),
                        ],
                      ),

                      SizedBox(height: 10),

                      // Progress bar or any extra element
                      Container(
                        height: 5,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Placeholder for any extra progress or decorative element
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Answer Buttons
class QuizOptionButton extends StatelessWidget {
  final String label;

  const QuizOptionButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your logic for button press here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16, // Responsive font size
          color: Colors.white,
        ),
      ),
    );
  }
}
