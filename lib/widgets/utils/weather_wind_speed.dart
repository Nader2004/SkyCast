
import 'package:shared_preferences/shared_preferences.dart';

String getWeatherWindSpeed(double windSpeed, SharedPreferences prefs) {
  final String selectedWindSpeedUnit = prefs.getString('windSpeedUnit') ?? 'km/h';
  final kmh = windSpeed.round();
  final mps = (windSpeed * 0.277778).round();
  return selectedWindSpeedUnit == 'km/h' ? '$kmh km/h' : '$mps m/s';
}