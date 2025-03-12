import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = "d8bb0cbda15f4d69b7250350250703";
  static const String baseUrl = "https://api.weatherapi.com/v1/history.json";

  static Future<Map<String, dynamic>?> getWeather(
    String city,
    String date,
  ) async {
    final Uri url = Uri.parse("$baseUrl?key=$apiKey&q=$city&dt=$date");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}
