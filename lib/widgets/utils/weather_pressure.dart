import 'package:shared_preferences/shared_preferences.dart';

/// Returns the pressure formatted according to the user's preference.
///
/// The [pressure] parameter is the pressure in hPa (hectopascals).
/// The [prefs] parameter is a [SharedPreferences] instance used to retrieve
/// the user's preferred pressure unit.
///
/// The function retrieves the user's preferred pressure unit from the
/// shared preferences. If the preference is 'hPa', the pressure is returned
/// in hectopascals. If the preference is 'mmHg', the pressure is converted
/// to millimeters of mercury and returned.
///
/// Example:
/// ```dart
/// final pressure = 1013;
/// final prefs = await SharedPreferences.getInstance();
/// final formattedPressure = getWeatherPressure(pressure, prefs); // Returns '1013 hPa' or '760 mmHg'
/// ```
String getWeatherPressure(int pressure, SharedPreferences prefs) {
  final String selectedPressureUnit = prefs.getString('pressureUnit') ?? 'hPa';
  final int hPa = pressure;
  final int mmHg = (pressure * 0.750062).round();
  return selectedPressureUnit == 'hPa' ? '$hPa hPa' : '$mmHg mmHg';
}