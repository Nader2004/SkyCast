import 'package:intl/intl.dart';
import 'package:sky_cast/models/daily.dart';

String getWeatherDayName(Daily daily) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000);
  final String dayName = DateFormat('EE').format(date);

  return dayName;
}
