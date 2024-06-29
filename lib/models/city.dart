import 'package:sky_cast/constants/country_codes.dart';

class City {
  final String name;
  final double lon;
  final double lat;
  final String country;
  final bool isMyLocation;
  final int? orderIndex;

  const City({
    required this.name,
    required this.lon,
    required this.lat,
    required this.country,
    this.isMyLocation = false,
    this.orderIndex,
  });

  City setIsMyLocation(bool isMyLocation) {
    return City(
      name: name,
      lon: lon,
      lat: lat,
      country: country,
      isMyLocation: isMyLocation,
    );
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      lon: json['lon'],
      lat: json['lat'],
      country: countryCodes
          .where((x) => json['country'] == x['code'])
          .first['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lon': lon,
      'lat': lat,
      'country': countryCodes.where((x) => x['name'] == country).first['code']
          as String,
      'isMyLocation': isMyLocation ? 1 : 0,
      'orderIndex': orderIndex,
    };
  }

  City copyWith({
    String? name,
    double? lon,
    double? lat,
    String? country,
    bool? isMyLocation,
    int? orderIndex,
  }) {
    return City(
      name: name ?? this.name,
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      country: country ?? this.country,
      isMyLocation: isMyLocation ?? this.isMyLocation,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  String toString() {
    return 'City{name: $name, lon: $lon, lat: $lat, country: $country, isMyLocation: $isMyLocation, orderIndex: $orderIndex}';
  }
}
