/// A class representing the "feels like" temperature data for different times of the day.
class DailyFeelsLike {
  /// The "feels like" temperature during the day.
  final double day;

  /// The "feels like" temperature during the night.
  final double night;

  /// The "feels like" temperature during the evening.
  final double eve;

  /// The "feels like" temperature during the morning.
  final double morn;

  /// Creates a [DailyFeelsLike] object.
  ///
  /// All parameters are required and must not be null.
  const DailyFeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  /// Creates a [DailyFeelsLike] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory DailyFeelsLike.fromJson(Map<String, dynamic> json) => DailyFeelsLike(
        day: (json['day'] ?? 0.0)
            .toDouble(), // Converts day to double, defaulting to 0.0 if missing
        night: (json['night'] ?? 0.0)
            .toDouble(), // Converts night to double, defaulting to 0.0 if missing
        eve: (json['eve'] ?? 0.0)
            .toDouble(), // Converts eve to double, defaulting to 0.0 if missing
        morn: (json['morn'] ?? 0.0)
            .toDouble(), // Converts morn to double, defaulting to 0.0 if missing
      );
}
