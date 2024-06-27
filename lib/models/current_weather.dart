import 'weather_description.dart';

/// A class representing the current weather data.
class CurrentWeather {
  /// The time of the data point in Unix timestamp format.
  final int dt;

  /// The time of sunrise in Unix timestamp format.
  final int sunrise;

  /// The time of sunset in Unix timestamp format.
  final int sunset;

  /// The current temperature.
  final double temp;

  /// The current "feels like" temperature.
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

  /// The weather conditions at the time of the data point.
  final List<WeatherDescription> weather;

  /// Creates a [CurrentWeather] object.
  ///
  /// All parameters are required and must not be null.
  const CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
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
    required this.weather,
  });

  /// Creates a [CurrentWeather] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        dt: json['dt'] ?? 0, // Default to 0 if dt is missing
        sunrise: json['sunrise'] ?? 0, // Default to 0 if sunrise is missing
        sunset: json['sunset'] ?? 0, // Default to 0 if sunset is missing
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
        weather: json['weather'] == null
            ? [] // Default to empty list if weather is missing
            : List<WeatherDescription>.from(json['weather'].map((x) =>
                WeatherDescription.fromJson(
                    x))), // Parses weather description data
      );
}
