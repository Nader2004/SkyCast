
import 'package:shared_preferences/shared_preferences.dart';

String getWeatherTemprature(double temprature, SharedPreferences prefs)  {
  final String selectedTemperatureUnit = prefs.getString('temperatureUnit') ?? 'Celcius';
  final celcius = (temprature - 273.15).round();
  final fahrenheit = ((temprature - 273.15) * 9 / 5 + 32).round();
  return selectedTemperatureUnit == 'Celcius' ? '$celcius°C' : '$fahrenheit°F';
}