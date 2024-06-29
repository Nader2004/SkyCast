import 'dart:convert';
import 'package:flutter/foundation.dart'; // Import foundation for compute
import 'package:http/http.dart' as http;
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Top-level function for parsing weather data
WeatherData parseWeatherData(String responseBody) {
  return WeatherData.fromJson(json.decode(responseBody));
}

// Top-level function for parsing city data
List<City> parseCityData(String responseBody) {
  final body = json.decode(responseBody) as List;
  return body.map((city) => City.fromJson(city)).toList();
}

class WeatherApiService {
  final String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
  final String baseCityQueryUrl =
      'http://api.openweathermap.org/geo/1.0/direct';
  final String apiKey = dotenv.env['WEATHER_API_KEY']!;

  Future<WeatherData?> fetchWeather(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey'),
      );

      if (response.statusCode == 200) {
        // Use compute to parse weather data in a separate isolate
        return compute(parseWeatherData, response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      debugPrint('Failed to connect to the API');
      return null;
    }
  }

  Future<List<City>> fetchCity(String cityName) async {
    try {
      final response = await http.get(
        Uri.parse('$baseCityQueryUrl?q=$cityName&limit=10&appid=$apiKey'),
      );
      if (response.statusCode == 200) {
        // Use compute to parse city data in a separate isolate
        return compute(parseCityData, response.body);
      } else {
        throw Exception('Failed to load city data');
      }
    } catch (e) {
      debugPrint('Failed to connect to the API');
      return [];
    }
  }
}
