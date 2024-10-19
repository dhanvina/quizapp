import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenSize = MediaQuery.of(context).size;

    // Define a base width and height for scaling
    const baseWidth = 1440.0; // Example base width (for 1440p screens)
    const baseHeight = 900.0; // Example base height

    // Calculate scaling factors
    final widthFactor = screenSize.width / baseWidth;
    final heightFactor = screenSize.height / baseHeight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/success_background.png'), // Replace with your image path
            fit: BoxFit
                .contain, // Use BoxFit.contain to fit the image within the container
          ),
        ),
        child: Center(
          child: Container(
            width: 300 * widthFactor, // Responsive width
            height: 500 * heightFactor, // Responsive height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  30 * widthFactor), // Responsive border radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Checkmark Icon
                Container(
                  width: 120 * widthFactor, // Responsive width
                  height: 120 * widthFactor, // Responsive height
                  decoration: BoxDecoration(
                    color: Color(0xFF3CB043), // Circle green color
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      size: 80 * widthFactor, // Responsive icon size
                      color: Colors.white, // Inner check icon color
                    ),
                  ),
                ),
                SizedBox(height: 30 * heightFactor), // Responsive spacing

                // Text "You did it!" and "Well Done!"
                Text(
                  'You did it!',
                  style: TextStyle(
                    fontSize: 28 * widthFactor, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Well Done!',
                  style: TextStyle(
                    fontSize: 28 * widthFactor, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30 * heightFactor), // Responsive spacing

                // Button to return to Dashboard
                ElevatedButton(
                  onPressed: () {
                    // Action when button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40 * widthFactor, // Responsive padding
                      vertical: 15 * heightFactor, // Responsive padding
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10 * widthFactor), // Responsive border radius
                    ),
                  ),
                  child: Text(
                    'Return to Dashboard',
                    style: TextStyle(
                      fontSize: 18 * widthFactor, // Responsive font size
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
