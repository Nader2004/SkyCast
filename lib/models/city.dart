class City {
  final String name;
  final double lon;
  final double lat;
  final String country;
  final bool isMyLocation;

  const City({
    required this.name,
    required this.lon,
    required this.lat,
    required this.country,
    this.isMyLocation = false,
  });
}
