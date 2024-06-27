import 'package:shared_preferences/shared_preferences.dart';

/// Returns the wind speed formatted according to the user's preference.
///
/// The [windSpeed] parameter is the wind speed in km/h.
/// The [prefs] parameter is a [SharedPreferences] instance used to retrieve
/// the user's preferred wind speed unit.
///
/// The function retrieves the user's preferred wind speed unit from the
/// shared preferences. If the preference is 'km/h', the wind speed is returned
/// in kilometers per hour. If the preference is 'm/s', the wind speed is
/// converted to meters per second and returned.
///
/// Example:
/// ```dart
/// final windSpeed = 10.0;
/// final prefs = await SharedPreferences.getInstance();
/// final formattedWindSpeed = getWeatherWindSpeed(windSpeed, prefs); // Returns '10 km/h' or '3 m/s'
/// ```
String getWeatherWindSpeed(double windSpeed, SharedPreferences prefs) {
  final String selectedWindSpeedUnit = prefs.getString('windSpeedUnit') ?? 'km/h';
  final int kmh = windSpeed.round();
  final int mps = (windSpeed * 0.277778).round();
  return selectedWindSpeedUnit == 'km/h' ? '$kmh km/h' : '$mps m/s';
}