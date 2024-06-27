import 'daily_feels_like.dart';
import 'daily_temprature.dart';
import 'weather_description.dart';

/// A class representing daily weather data.
class Daily {
  /// The time of the data point in Unix timestamp format.
  final int dt;

  /// The time of sunrise in Unix timestamp format.
  final int sunrise;

  /// The time of sunset in Unix timestamp format.
  final int sunset;

  /// The time of moonrise in Unix timestamp format.
  final int moonrise;

  /// The time of moonset in Unix timestamp format.
  final int moonset;

  /// The phase of the moon.
  final double moonPhase;

  /// The daily temperature data.
  final DailyTemperature temp;

  /// The daily feels-like temperature data.
  final DailyFeelsLike feelsLike;

  /// The summary of the daily weather.
  final String summary;

  /// The atmospheric pressure at the time of the data point.
  final int pressure;

  /// The humidity percentage at the time of the data point.
  final int humidity;

  /// The dew point temperature at the time of the data point.
  final double dewPoint;

  /// The wind speed at the time of the data point.
  final double windSpeed;

  /// The wind direction in degrees at the time of the data point.
  final int windDeg;

  /// The wind gust speed at the time of the data point.
  final double windGust;

  /// The weather conditions at the time of the data point.
  final List<WeatherDescription> weather;

  /// The cloudiness percentage at the time of the data point.
  final int clouds;

  /// The probability of precipitation at the time of the data point.
  final double pop;

  /// The amount of rain in millimeters at the time of the data point.
  final double rain;

  /// The UV index at the time of the data point.
  final double uvi;

  /// Creates a [Daily] object.
  ///
  /// All parameters are required and must not be null.
  const Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.summary,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  /// Creates a [Daily] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] ?? 0, // Default to 0 if dt is missing
        sunrise: json['sunrise'] ?? 0, // Default to 0 if sunrise is missing
        sunset: json['sunset'] ?? 0, // Default to 0 if sunset is missing
        moonrise: json['moonrise'] ?? 0, // Default to 0 if moonrise is missing
        moonset: json['moonset'] ?? 0, // Default to 0 if moonset is missing
        moonPhase: (json['moon_phase'] ?? 0.0)
            .toDouble(), // Converts moon_phase to double, defaulting to 0.0 if missing
        temp: DailyTemperature.fromJson(
            json['temp']), // Parses daily temperature data
        feelsLike: DailyFeelsLike.fromJson(
            json['feels_like']), // Parses daily feels-like temperature data
        summary: json['summary'] ??
            '', // Default to empty string if summary is missing
        pressure: json['pressure'] ?? 0, // Default to 0 if pressure is missing
        humidity: json['humidity'] ?? 0, // Default to 0 if humidity is missing
        dewPoint: (json['dew_point'] ?? 0.0)
            .toDouble(), // Converts dew_point to double, defaulting to 0.0 if missing
        windSpeed: (json['wind_speed'] ?? 0.0)
            .toDouble(), // Converts wind_speed to double, defaulting to 0.0 if missing
        windDeg: json['wind_deg'] ?? 0, // Default to 0 if wind_deg is missing
        windGust: (json['wind_gust'] ?? 0.0)
            .toDouble(), // Converts wind_gust to double, defaulting to 0.0 if missing
        weather: List<WeatherDescription>.from(json['weather'].map((x) =>
            WeatherDescription.fromJson(x))), // Parses weather description data
        clouds: json['clouds'] ?? 0, // Default to 0 if clouds is missing
        pop: (json['pop'] ?? 0.0)
            .toDouble(), // Converts pop to double, defaulting to 0.0 if missing
        rain: (json['rain'] ?? 0.0)
            .toDouble(), // Converts rain to double, defaulting to 0.0 if missing
        uvi: (json['uvi'] ?? 0.0)
            .toDouble(), // Converts uvi to double, defaulting to 0.0 if missing
      );
}
