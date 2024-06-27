import 'current_weather.dart';
import 'daily.dart';
import 'hourly.dart';
import 'minutely.dart';

/// A class representing weather data for a specific location.
class WeatherData {
  /// The latitude of the location.
  final double lat;

  /// The longitude of the location.
  final double lon;

  /// The timezone of the location.
  final String timezone;

  /// The offset from UTC in seconds for the location's timezone.
  final int timezoneOffset;

  /// The current weather data.
  final CurrentWeather current;

  /// The minutely weather data.
  final List<Minutely> minutely;

  /// The hourly weather data.
  final List<Hourly> hourly;

  /// The daily weather data.
  final List<Daily> daily;

  /// Creates a [WeatherData] object.
  ///
  /// All parameters are required and must not be null.
  const WeatherData({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
  });

  /// Creates a [WeatherData] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        lat: json['lat'].toDouble(), // Converts latitude to double
        lon: json['lon'].toDouble(), // Converts longitude to double
        timezone: json['timezone'] ??
            '', // Default to empty string if timezone is missing
        timezoneOffset: json['timezone_offset'] ??
            0, // Default to 0 if timezone offset is missing
        current: CurrentWeather.fromJson(
            json['current']), // Parses current weather data
        minutely: json['minutely'] == null
            ? [] // Default to empty list if minutely data is missing
            : List<Minutely>.from(json['minutely'].map(
                (x) => Minutely.fromJson(x))), // Parses minutely weather data
        hourly: json['hourly'] == null
            ? [] // Default to empty list if hourly data is missing
            : List<Hourly>.from(json['hourly']
                .map((x) => Hourly.fromJson(x))), // Parses hourly weather data
        daily: json['daily'] == null
            ? [] // Default to empty list if daily data is missing
            : List<Daily>.from(json['daily']
                .map((x) => Daily.fromJson(x))), // Parses daily weather data
      );
}
