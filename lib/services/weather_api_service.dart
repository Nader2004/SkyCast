import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_cast/models/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiService {
  final String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
  final String apiKey = dotenv.env['WEATHER_API_KEY']!;

  Future<WeatherData> fetchWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
