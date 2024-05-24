import 'weather_description.dart';

class Hourly {
  final int dt;
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
  final double windGust;
  final List<WeatherDescription> weather;
  final double pop;

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

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] ?? 0.0,
        temp: json['temp'].toDouble() ?? 0.0,
        feelsLike: json['feels_like'].toDouble() ?? 0.0,
        pressure: json['pressure'] ?? 0,
        humidity: json['humidity'] ?? 0,
        dewPoint: json['dew_point'].toDouble() ?? 0.0,
        uvi: json['uvi'].toDouble() ?? 0.0,
        clouds: json['clouds'] ?? 0,
        visibility: json['visibility'].toInt() ?? 0,
        windSpeed: json['wind_speed'].toDouble() ?? 0.0,
        windDeg: json['wind_deg'] ?? 0,
        windGust: json['wind_gust'].toDouble() ?? 0.0,
        weather: json['weather'] == null
            ? []
            : List<WeatherDescription>.from(
                json['weather'].map((x) => WeatherDescription.fromJson(x))),
        pop: json['pop'].toDouble() ?? 0.0,
      );
}
