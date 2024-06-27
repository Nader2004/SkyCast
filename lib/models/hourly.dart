import 'weather_description.dart';

/// A class representing hourly weather data.
class Hourly {
  /// The time of the data point in Unix timestamp format.
  final int dt;

  /// The temperature at the time of the data point.
  final double temp;

  /// The perceived temperature at the time of the data point.
  final double feelsLike;

  /// The atmospheric pressure at the time of the data point.
  final int pressure;

  /// The humidity percentage at the time of the data point.
  final int humidity;

  /// The dew point temperature at the time of the data point.
  final double dewPoint;

  /// The UV index at the time of the data point.
  final double uvi;

  /// The cloudiness percentage at the time of the data point.
  final int clouds;

  /// The visibility in meters at the time of the data point.
  final int visibility;

  /// The wind speed at the time of the data point.
  final double windSpeed;

  /// The wind direction in degrees at the time of the data point.
  final int windDeg;

  /// The wind gust speed at the time of the data point.
  final double windGust;

  /// The weather conditions at the time of the data point.
  final List<WeatherDescription> weather;

  /// The probability of precipitation at the time of the data point.
  final double pop;

  /// Creates an [Hourly] object.
  ///
  /// All parameters are required and must not be null.
  const Hourly({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
  });

  /// Creates an [Hourly] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] ?? 0, // Default to 0 if dt is missing
        temp: (json['temp'] ?? 0.0)
            .toDouble(), // Converts temp to double, defaulting to 0.0 if missing
        feelsLike: (json['feels_like'] ?? 0.0)
            .toDouble(), // Converts feels_like to double, defaulting to 0.0 if missing
        pressure: json['pressure'] ?? 0, // Default to 0 if pressure is missing
        humidity: json['humidity'] ?? 0, // Default to 0 if humidity is missing
        dewPoint: (json['dew_point'] ?? 0.0)
            .toDouble(), // Converts dew_point to double, defaulting to 0.0 if missing
        uvi: (json['uvi'] ?? 0.0)
            .toDouble(), // Converts uvi to double, defaulting to 0.0 if missing
        clouds: json['clouds'] ?? 0, // Default to 0 if clouds is missing
        visibility:
            json['visibility'] ?? 0, // Default to 0 if visibility is missing
        windSpeed: (json['wind_speed'] ?? 0.0)
            .toDouble(), // Converts wind_speed to double, defaulting to 0.0 if missing
        windDeg: json['wind_deg'] ?? 0, // Default to 0 if wind_deg is missing
        windGust: (json['wind_gust'] ?? 0.0)
            .toDouble(), // Converts wind_gust to double, defaulting to 0.0 if missing
        weather: json['weather'] == null
            ? [] // Default to empty list if weather is missing
            : List<WeatherDescription>.from(json['weather'].map((x) =>
                WeatherDescription.fromJson(
                    x))), // Parses weather description data
        pop: (json['pop'] ?? 0.0)
            .toDouble(), // Converts pop to double, defaulting to 0.0 if missing
      );
}
