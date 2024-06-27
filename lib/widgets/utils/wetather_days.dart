import 'package:intl/intl.dart';
import 'package:sky_cast/models/daily.dart';

/// Returns the name of the day for the given [Daily] weather data.
///
/// The [daily] parameter is a [Daily] object that contains the date
/// information in Unix time (seconds since epoch).
///
/// The function converts the Unix time to a [DateTime] object and
/// formats it to a day name using the 'EE' pattern (e.g., Mon, Tue, etc.).
///
/// Example:
/// ```dart
/// final daily = Daily(dt: 1632960000);
/// final dayName = getWeatherDayName(daily); // Returns 'Mon'
/// ```
String getWeatherDayName(Daily daily) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000);
  final String dayName = DateFormat('EE').format(date);

  return dayName;
}