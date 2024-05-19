class Minutely {
  final int dt;
  final double precipitation;

 const Minutely({
    required this.dt,
    required this.precipitation,
  });

  factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json['dt'],
        precipitation: json['precipitation'].toDouble(),
      );
}