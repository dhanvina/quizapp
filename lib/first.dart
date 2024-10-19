import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // School name with Poppins Bold Italic
                Text(
                  'Mount Carmel English School',
                  style: TextStyle(
                    fontSize: 26, // Updated font size
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic, // Italic style
                    fontFamily: 'Poppins', // Font family
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20), // Space between school name and container

                // Main container with background image
                Container(
                  width: 300, // Adjust width to match the image's aspect ratio
                  height: 450, // Adjust height accordingly
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/rectangle3.png'), // Updated asset name
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      // Character image with specified size
                      Align(
                        alignment: Alignment.topCenter, // Align image to top
                        child: Container(
                          width: 220, // Adjusted width of the image
                          height: 220, // Adjusted height of the image
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/thinking_cap_1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // Message box with overlap
                      Positioned(
                        top: 250, // Adjusted position to align with image
                        left: 10,
                        right: 10,
                        child: Container(
                          width: 300,
                          height: 300,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // "Ready to excel" text
                              Text(
                                'Ready to excel this Test?',
                                style: TextStyle(
                                  fontSize: 28, // Adjusted font size
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: Offset(2, 2),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10), // Space between texts

                              // "Hold your ears" text
                              Text(
                                'Hold your ears,\nRoll and Unroll\nthem gently.',
                                style: TextStyle(
                                  fontSize: 24, // Adjusted font size
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
