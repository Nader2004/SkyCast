import 'package:shared_preferences/shared_preferences.dart';

String getWeatherPressure(int pressure, SharedPreferences prefs) {
  final String selectedPressureUnit = prefs.getString('pressureUnit') ?? 'hPa';
  final hPa = pressure;
  final mmHg =  (pressure * 0.750062).round();
  return selectedPressureUnit == 'hPa' ? '$hPa hPa' : '$mmHg mmHg';
}
