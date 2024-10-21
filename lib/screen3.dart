import 'package:flutter/material.dart';
import 'package:quizapp/screen1.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return MobileLayout();
            } else if (constraints.maxWidth < 1200) {
              // Tablet layout
              return TabletLayout();
            } else {
              // Web layout
              return WebLayout();
            }
          },
        ),
      ),
    );
  }
}

// Mobile layout
class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: Color(0xFFA3D83F),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 40,
                child: Image.asset(
                  'assets/quiz_preview.png',
                  width: 220,
                ),
              ),
              Positioned(
                bottom: 90,
                left: 20,
                right: 20,
                child: InfoBox(),
              ),
              Positioned(
                bottom: 70,
                left: 105,
                child: ArrowButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tablet layout
class TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          width: 500,
          height: 600,
          decoration: BoxDecoration(
            color: Color(0xFFA3D83F),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 80,
                child: Image.asset(
                  'assets/quiz_preview.png',
                  width: 340,
                ),
              ),
              // Adjusted bottom to move the InfoBox and ArrowButton down
              Positioned(
                bottom: 40,  // Increased bottom value to move it down
                left: 40,
                right: 40,
                child: InfoBox(),
              ),
              Positioned(
                bottom: 20,  // Increased bottom value to move it down
                left: 200,
                child: ArrowButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Web layout
class WebLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          width: 700,
          height: 700,
          decoration: BoxDecoration(
            color: Color(0xFFA3D83F),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 120,
                child: Image.asset(
                  'assets/quiz_preview.png',
                  width: 460,
                ),
              ),
              // Adjusted bottom to move the InfoBox and ArrowButton down
              Positioned(
                bottom: 40,  // Increased bottom value to move it down
                left: 60,
                right: 60,
                child: InfoBox(),
              ),
              Positioned(
                bottom: 20,  // Increased bottom value to move it down
                left: 300,
                child: ArrowButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// InfoBox Widget (White Box with Test Information)
class InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Text(
            'TEST 1',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              color: Color(0xFF4C2671),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'There are a total of',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          Text(
            '20 questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Time – 10:00',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              color: Color(0xFF4C2671),
            ),
          ),
        ],
      ),
    );
  }
}

// ArrowButton Widget
class ArrowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the FirstPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstPage()),
        );
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF00A455),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
