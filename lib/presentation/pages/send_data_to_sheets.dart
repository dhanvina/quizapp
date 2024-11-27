import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSheetsAPI {
  static const String _webAppUrl =
      "https://script.google.com/macros/s/AKfycbwOvA7QeQZZqZT4SIOFzPoPX4sYQmJr6k4x5xoTcGiINv-g7jNxYqW2PxIlzms-s5s1/exec"; // Replace with your Google Apps Script URL

  // Function to send data via POST request with dynamic values (from SharedPreferences)
  static Future<void> sendIDToSheet() async {
    try {
      // Retrieve the ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString('id');
      String? paper = prefs.getString('paper');
      String? score = prefs.getString('score');

      print('Retrieved ID: $id');
      print('Retrieved paper: $paper');
      print('Retrieved score: $score');

      // Check if the id is retrieved successfully
      if (id == null || id.trim().isEmpty) {
        print('No ID found in SharedPreferences');
        return; // Exit if ID is not found
      }

      if (paper == null) {
        print('No paper found in SharedPreferences');
        return; // Exit if ID is not found
      }

      if (score == null) {
        print('No score found in SharedPreferences');
        return; // Exit if ID is not found
      }

      final response = await http.post(
        Uri.parse(_webAppUrl),
        body: {'id': id, 'paper': paper, 'score': score},
      );

      // Check the response status
      if (response.statusCode == 200 && response.body.contains("Success")) {
        // Handle success
        print('Data sent successfully');
      } else {
        // Handle error
        print('Failed to send data');
      }
    } catch (error) {
      // Handle any exception that occurs
      print('Error: $error');
    }
  }
}
