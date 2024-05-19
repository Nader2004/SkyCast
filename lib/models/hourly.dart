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

  Hourly({
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
        dt: json['dt'],
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        pressure: json['pressure'],
        humidity: json['humidity'],
        dewPoint: json['dew_point'].toDouble(),
        uvi: json['uvi'].toDouble(),
        clouds: json['clouds'],
        visibility: json['visibility'].toInt(),
        windSpeed: json['wind_speed'].toDouble(),
        windDeg: json['wind_deg'],
        windGust: json['wind_gust'].toDouble(),
        weather: List<WeatherDescription>.from(
            json['weather'].map((x) => WeatherDescription.fromJson(x))),
        pop: json['pop'].toDouble(),
      );
}
