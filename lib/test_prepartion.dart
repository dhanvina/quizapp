import 'package:flutter/material.dart';

class TestPreparationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Move the school name outside of the green container
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Mount Carmel English School',
                style: TextStyle(
                  fontSize: size.width * 0.03, // Responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // The green container starts here
            Container(
              padding: EdgeInsets.all(20),
              width: size.width * 0.8, // 80% of screen width for responsiveness
              height: size.height * 0.7, // Adjust height for responsiveness
              decoration: BoxDecoration(
                color: const Color(0xFFA2D12C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 0.4,
                    child: Image.asset(
                      'assets/relaxing_person.png', // Add your image path here
                      fit: BoxFit.contain,
                    ),
                  ),
                  // The "Ready to excel this Test?" text
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Ready to excel\nthis Test?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.05, // Responsive font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Take a\ndeep breath,\nyou\'ve got this!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.04, // Responsive font size
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
