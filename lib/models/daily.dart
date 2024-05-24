import 'daily_feels_like.dart';
import 'daily_temprature.dart';
import 'weather_description.dart';

class Daily {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final DailyTemperature temp;
  final DailyFeelsLike feelsLike;
  final String summary;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final List<WeatherDescription> weather;
  final int clouds;
  final double pop;
  final double rain;
  final double uvi;

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

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] ?? 0,
        sunrise: json['sunrise'] ?? 0,
        sunset: json['sunset'] ?? 0,
        moonrise: json['moonrise'] ?? 0,
        moonset: json['moonset'] ?? 0,
        moonPhase: json['moon_phase'].toDouble() ?? 0.0,
        temp: DailyTemperature.fromJson(json['temp']),
        feelsLike: DailyFeelsLike.fromJson(json['feels_like']),
        summary: json['summary'] ?? '',
        pressure: json['pressure'] ?? 0,
        humidity: json['humidity'] ?? 0,
        dewPoint: json['dew_point'].toDouble() ?? 0,
        windSpeed: json['wind_speed'].toDouble() ?? 0,
        windDeg: json['wind_deg'] ?? 0,
        windGust: json['wind_gust'].toDouble() ?? 0,
        weather: List<WeatherDescription>.from(
            json['weather'].map((x) => WeatherDescription.fromJson(x))),
        clouds: json['clouds'] ?? 0,
        pop: json['pop'].toDouble() ?? 0.0,
        rain: json['rain'] ?? 0.0,
        uvi: json['uvi'].toDouble() ?? 0.0,
      );
}
