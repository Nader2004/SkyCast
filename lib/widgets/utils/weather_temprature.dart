import 'package:shared_preferences/shared_preferences.dart';

/// Returns the temperature formatted according to the user's preference.
///
/// The [temperature] parameter is the temperature in Kelvin.
/// The [prefs] parameter is a [SharedPreferences] instance used to retrieve
/// the user's preferred temperature unit.
///
/// The function retrieves the user's preferred temperature unit from the
/// shared preferences. If the preference is 'Celsius', the temperature is
/// converted to degrees Celsius and returned. If the preference is 'Fahrenheit',
/// the temperature is converted to degrees Fahrenheit and returned.
///
/// Example:
/// ```dart
/// final temperature = 300.0;
/// final prefs = await SharedPreferences.getInstance();
/// final formattedTemperature = getWeatherTemperature(temperature, prefs); // Returns '27°C' or '80°F'
/// ```
String getWeatherTemprature(double temperature, SharedPreferences prefs) {
  final String selectedTemperatureUnit = prefs.getString('temperatureUnit') ?? 'Celsius';
  final int celsius = (temperature - 273.15).round();
  final int fahrenheit = ((temperature - 273.15) * 9 / 5 + 32).round();
  return selectedTemperatureUnit == 'Celsius' ? '$celsius°C' : '$fahrenheit°F';
}