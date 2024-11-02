import 'package:flutter/material.dart';
import 'package:quizapp/presentation/widgets/app_bar_widget.dart';

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
                AppBarWidget(),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 400,
                  height: 500,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA2D12C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Image.asset(
                          'assets/motivation_screen1.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                              'Hold your ears,\nRoll and Unroll\nthem gently.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
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
