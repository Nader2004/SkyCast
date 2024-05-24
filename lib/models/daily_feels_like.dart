class DailyFeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

 const DailyFeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory DailyFeelsLike.fromJson(Map<String, dynamic> json) => DailyFeelsLike(
        day: json['day'].toDouble() ?? 0.0,
        night: json['night'].toDouble() ?? 0.0,
        eve: json['eve'].toDouble() ?? 0.0,
        morn: json['morn'].toDouble() ?? 0.0,
      );
}
