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
      String? id = prefs.getString(
          'id'); // Replace 'user_id' with your actual SharedPreferences key

      print('Retrieved ID: $id');

      // Check if the id is retrieved successfully
      if (id == null) {
        print('No ID found in SharedPreferences');
        return; // Exit if ID is not found
      }

      final response = await http.post(
        Uri.parse(_webAppUrl),
        body: {
          'id': id, // Dynamic ID from SharedPreferences
        },
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
