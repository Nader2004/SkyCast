class WeatherDescription {
  final int id;
  final String main;
  final String description;
  final String icon;

 const WeatherDescription({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      WeatherDescription(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );
}
