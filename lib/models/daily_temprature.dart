/// A class representing daily temperature data.
class DailyTemperature {
  /// The temperature during the day.
  final double day;

  /// The minimum temperature during the day.
  final double min;

  /// The maximum temperature during the day.
  final double max;

  /// The temperature during the night.
  final double night;

  /// The temperature during the evening.
  final double eve;

  /// The temperature during the morning.
  final double morn;

  /// Creates a [DailyTemperature] object.
  ///
  /// All parameters are required and must not be null.
  const DailyTemperature({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  /// Creates a [DailyTemperature] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory DailyTemperature.fromJson(Map<String, dynamic> json) =>
      DailyTemperature(
        day: (json['day'] ?? 0.0)
            .toDouble(), // Converts day to double, defaulting to 0.0 if missing
        min: (json['min'] ?? 0.0)
            .toDouble(), // Converts min to double, defaulting to 0.0 if missing
        max: (json['max'] ?? 0.0)
            .toDouble(), // Converts max to double, defaulting to 0.0 if missing
        night: (json['night'] ?? 0.0)
            .toDouble(), // Converts night to double, defaulting to 0.0 if missing
        eve: (json['eve'] ?? 0.0)
            .toDouble(), // Converts eve to double, defaulting to 0.0 if missing
        morn: (json['morn'] ?? 0.0)
            .toDouble(), // Converts morn to double, defaulting to 0.0 if missing
      );
}
