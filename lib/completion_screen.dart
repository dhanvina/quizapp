import 'package:flutter/material.dart';
import 'package:quizapp/dashboard.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenSize = MediaQuery.of(context).size;

    // Calculate 70% of the width and height
    final containerWidth = screenSize.width * 0.7;
    final containerHeight = screenSize.height * 0.7;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/quiz_app_background.png'), // Background image (transparent)
            fit: BoxFit.fill, // Fill the screen with the image
          ),
        ),
        child: Center(
          child: Container(
            width: containerWidth, // 70% of the screen width
            height: containerHeight, // 70% of the screen height
            decoration: BoxDecoration(
              color: Color(0xFF9DCC29), // Green background color (#9DCC29)
              borderRadius: BorderRadius.circular(30), // Fixed border radius for smooth corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color
                  blurRadius: 10, // Shadow blur radius
                  offset: Offset(0, 5), // Shadow offset
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Outer circle with green color and thinner white border
                Container(
                  width: 200, // Outer circle size
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFF00A455), // Outer green color
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // White border for the outer circle
                      width: 1, // Thinner border width for outer circle
                    ),
                    boxShadow: [
                      // Blue glow effect outside the inner circle
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4), // Blue glow effect
                        blurRadius: 30, // Glow radius
                        spreadRadius: 15, // Spread of the blue glow
                        offset: Offset(0, 0), // Glow outside all directions
                      ),
                    ],
                  ),
                  child: Center(
                    // Inner circle with thinner white border
                    child: Container(
                      width: 140, // Inner circle size
                      height: 140,
                      decoration: BoxDecoration(
                        color: Color(0xFF3CB043), // Darker green color for inner circle
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white, // White border for the inner circle
                          width: 1, // Thinner border width for inner circle
                        ),
                      ),
                      child: Center(
                        // Bolder Checkmark Icon
                        child: Icon(
                          Icons.check, // Checkmark icon
                          size: 80, // Increase size for a bolder effect
                          color: Colors.white, // White checkmark
                          weight: 900, // Make the checkmark icon as bold as possible
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30), // Fixed spacing

                // Text "You did it!" and "Well Done!" with more boldness
                Text(
                  'You did it!',
                  style: TextStyle(
                    fontSize: 28, // Fixed font size
                    fontWeight: FontWeight.w900, // Increased boldness
                    color: Colors.white, // Text color white
                  ),
                ),
                Text(
                  'Well Done!',
                  style: TextStyle(
                    fontSize: 28, // Fixed font size
                    fontWeight: FontWeight.w900, // Increased boldness
                    color: Colors.white, // Text color white
                  ),
                ),
                SizedBox(height: 30), // Fixed spacing

                // Button to return to Dashboard with shadow
                ElevatedButton(
                  onPressed: () {
                    // Navigate to DashboardPage when button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40, // Fixed padding
                      vertical: 15, // Fixed padding
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Fixed border radius
                    ),
                    shadowColor: Colors.black.withOpacity(0.6), // Clearer shadow for button
                    elevation: 15, // Increased shadow elevation
                  ),
                  child: Text(
                    'Return to Dashboard',
                    style: TextStyle(
                      fontSize: 18, // Fixed font size
                      color: Colors.white,
                    ),
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
