import 'package:flutter/material.dart';

class FarmBackgroundWidget extends StatelessWidget {
  const FarmBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/farm_background.png"),
          fit: BoxFit.fill,
          alignment: Alignment
              .topCenter, // Adjust as needed for different screen sizes
        ),
      ),
    );
  }
}
