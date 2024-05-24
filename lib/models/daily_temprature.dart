class DailyTemperature {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

 const DailyTemperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory DailyTemperature.fromJson(Map<String, dynamic> json) =>
      DailyTemperature(
        day: json['day'].toDouble() ?? 0.0,
        min: json['min'].toDouble() ?? 0.0,
        max: json['max'].toDouble() ?? 0.0,
        night: json['night'].toDouble() ?? 0.0,
        eve: json['eve'].toDouble() ?? 0.0,
        morn: json['morn'].toDouble() ?? 0.0,
      );
}
