import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_cast/models/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A service class that interacts with the OpenWeatherMap API to fetch weather data.
class WeatherApiService {
  /// The base URL for the OpenWeatherMap API.
  final String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';

  /// The API key for authenticating requests to the OpenWeatherMap API.
  final String apiKey = dotenv.env['WEATHER_API_KEY']!;

  /// Fetches weather data for the given latitude and longitude.
  ///
  /// The [lat] parameter is the latitude of the location.
  /// The [lon] parameter is the longitude of the location.
  ///
  /// Returns a [WeatherData] object containing the weather data for the specified location.
  ///
  /// Throws an [Exception] if the request fails.
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