import 'package:flutter/material.dart';
import 'package:quizapp/presentation/widgets/app_bar_widget.dart';

class MotivationScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Move the school name outside of the green container
            AppBarWidget(),
            SizedBox(height: 20.0),
            // The green container starts here
            Container(
              padding: EdgeInsets.all(20),
              width: 400,
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFFA2D12C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    child: Image.asset(
                      'assets/motivation_screen2.png', // Add your image path here
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
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Take a\ndeep breath,\nyou\'ve got this!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins', // Use the Poppins font
                            fontSize: 14.0, // Responsive font size
                            fontWeight: FontWeight.bold, // Bold weight
                            color: Color(
                                0xFF00A455), // Hex color code for the specified green
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
