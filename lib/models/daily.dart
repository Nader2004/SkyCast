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
        dt: json['dt'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        moonrise: json['moonrise'],
        moonset: json['moonset'],
        moonPhase: json['moon_phase'].toDouble(),
        temp: DailyTemperature.fromJson(json['temp']),
        feelsLike: DailyFeelsLike.fromJson(json['feels_like']),
        pressure: json['pressure'],
        humidity: json['humidity'],
        dewPoint: json['dew_point'].toDouble(),
        windSpeed: json['wind_speed'].toDouble(),
        windDeg: json['wind_deg'],
        windGust: json['wind_gust'].toDouble(),
        weather: List<WeatherDescription>.from(
            json['weather'].map((x) => WeatherDescription.fromJson(x))),
        clouds: json['clouds'],
        pop: json['pop'].toDouble(),
        rain: json['rain'] ?? 0.0,
        uvi: json['uvi'].toDouble(),
      );
}
