import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSheetsAPI {
  static const String _googleSheetsAPIEndpoint =
      'https://script.google.com/macros/s/AKfycbwOvA7QeQZZqZT4SIOFzPoPX4sYQmJr6k4x5xoTcGiINv-g7jNxYqW2PxIlzms-s5s1/exec';

  static Future<void> sendIDToSheet() async {
    try {
      print('Attempting to send ID to Google Sheets...');

      // Retrieve the user ID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? Id = prefs.getString('id'); // Make sure this ID is stored

      print('Retrieved ID from SharedPreferences: $Id');

      if (Id != null && Id.isNotEmpty) {
        // Prepare the data to send (in this case, user ID)
        final body = json.encode({
          "Id": [
            [Id], // Send the user ID in the first column of the sheet
          ]
        });

        print('Prepared body for POST request: $body');

        // Send the POST request to Google Apps Script
        final response = await http.post(
          Uri.parse(_googleSheetsAPIEndpoint),
          headers: {
            'Content-Type': 'application/json',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: body,
        );

        // Check if the request was successful
        if (response.statusCode == 200) {
          print('ID successfully sent to Google Sheets');
        } else {
          print('Failed to send ID. Status Code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        print('User ID is not stored in SharedPreferences');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
