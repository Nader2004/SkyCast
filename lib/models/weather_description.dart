/// A class representing weather description data.
class WeatherDescription {
  /// The ID of the weather condition.
  final int id;

  /// The group of weather parameters (Rain, Snow, Extreme, etc.).
  final String main;

  /// The weather condition within the group.
  final String description;

  /// The icon ID for the weather condition.
  final String icon;

  /// Creates a [WeatherDescription] object.
  ///
  /// All parameters are required and must not be null.
  const WeatherDescription({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Creates a [WeatherDescription] object from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      WeatherDescription(
        id: json['id'] ?? 0, // Default to 0 if id is missing
        main: json['main'] ?? '', // Default to empty string if main is missing
        description: json['description'] ??
            '', // Default to empty string if description is missing
        icon: json['icon'] ?? '', // Default to empty string if icon is missing
      );
}
