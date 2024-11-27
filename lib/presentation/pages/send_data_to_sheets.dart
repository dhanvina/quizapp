import 'package:http/http.dart' as http;

class GoogleSheetsAPI {
  static const String _webAppUrl =
      "https://script.google.com/macros/s/AKfycbwOvA7QeQZZqZT4SIOFzPoPX4sYQmJr6k4x5xoTcGiINv-g7jNxYqW2PxIlzms-s5s1/exec"; // Replace with the actual URL of your Google Apps Script Web App

  // Function to send data via POST request with static values
  static Future<void> sendIDToSheet() async {
    try {
      final response = await http.post(
        Uri.parse(_webAppUrl),
        body: {
          'name': 'John Doe', // Static Name
          'email': 'john.doe@example.com', // Static Email
          'message': 'This is a static message from Flutter!', // Static Message
        },
      );

      // Check the response status
      if (response.statusCode == 200 && response.body.contains("Success")) {
        // Handle success
        print('Data sent successfully');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data sent successfully!")));
      } else {
        // Handle error
        print('Failed to send data');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send data")));
      }
    } catch (error) {
      // Handle any exception that occurs
      print('Error: $error');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $error")));
    }
  }
}
