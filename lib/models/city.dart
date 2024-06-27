/// A class representing a city with its geographical and location details.
class City {
  /// The name of the city.
  final String name;

  /// The longitude coordinate of the city.
  final double lon;

  /// The latitude coordinate of the city.
  final double lat;

  /// The country where the city is located.
  final String country;

  /// Indicates if this city is the user's current location.
  final bool isMyLocation;

  /// Creates a [City] object.
  ///
  /// The [name], [lon], [lat], and [country] parameters are required and must not be null.
  /// The [isMyLocation] parameter is optional and defaults to `false`.
  const City({
    required this.name,
    required this.lon,
    required this.lat,
    required this.country,
    this.isMyLocation = false,
  });
}
