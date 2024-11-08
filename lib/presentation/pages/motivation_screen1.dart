import 'package:flutter/material.dart';

class MotivationScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 450,
                  height: 550,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA2D12C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 320,
                        width: 420,
                        child: Transform.translate(
                          offset: Offset(
                              -20, 0),
                          child: Image.asset(
                            'assets/Ears.gif',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                                fontSize: 18.0, // Increased font size
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Hold your ears,\nRoll and Unroll\nthem gently.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.0, // Increased font size
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00A455),
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
      },
    );
  }
}
