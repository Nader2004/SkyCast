/// A class representing minutely weather data.
class Minutely {
  /// The time of the data point in Unix timestamp format.
  final int dt;

  /// The amount of precipitation in the given minute.
  final double precipitation;

  /// Creates a [Minutely] object.
  ///
  /// All parameters are required and must not be null.
  const Minutely({
    required this.dt,
    required this.precipitation,
  });

  /// Creates a [Minutely] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json['dt'] ?? 0, // Default to 0 if dt is missing
        precipitation: (json['precipitation'] ?? 0.0).toDouble(), // Converts precipitation to double, defaulting to 0.0 if missing
      );
}