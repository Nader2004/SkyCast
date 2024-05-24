class Minutely {
  final int dt;
  final double precipitation;

 const Minutely({
    required this.dt,
    required this.precipitation,
  });

  factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json['dt'] ?? 0.0,
        precipitation: json['precipitation'].toDouble() ?? 0.0,
      );
}