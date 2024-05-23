import 'weather_description.dart';

class CurrentWeather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final List<WeatherDescription> weather;

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

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        dt: json['dt'],
        sunrise: json['sunrise'] ?? 0,
        sunset: json['sunset'] ?? 0,
        temp: json['temp'].toDouble() ?? 0,
        feelsLike: json['feels_like'].toDouble() ?? 0,
        pressure: json['pressure'] ?? 0,
        humidity: json['humidity'] ?? 0,
        dewPoint: json['dew_point'].toDouble() ?? 0,
        uvi: json['uvi'].toDouble() ?? 0,
        clouds: json['clouds'] ?? 0,
        visibility: json['visibility'] ?? 0,
        windSpeed: json['wind_speed'].toDouble() ?? 0,
        windDeg: json['wind_deg'] ?? 0,
        weather: json['weather'] == null
            ? []
            : List<WeatherDescription>.from(
                json['weather'].map((x) => WeatherDescription.fromJson(x))),
      );
}
