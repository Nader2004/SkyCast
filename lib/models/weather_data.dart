 import 'current_weather.dart';
import 'daily.dart';
import 'hourly.dart';
import 'minutely.dart';

class WeatherData {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<Minutely> minutely;
  final List<Hourly> hourly;
  final List<Daily> daily;

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

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        lat: json['lat'].toDouble(),
        lon: json['lon'].toDouble(),
        timezone: json['timezone'],
        timezoneOffset: json['timezone_offset'],
        current: CurrentWeather.fromJson(json['current']),
        minutely: List<Minutely>.from(json['minutely'].map((x) => Minutely.fromJson(x))),
        hourly: List<Hourly>.from(json['hourly'].map((x) => Hourly.fromJson(x))),
        daily: List<Daily>.from(json['daily'].map((x) => Daily.fromJson(x))),
      );
}