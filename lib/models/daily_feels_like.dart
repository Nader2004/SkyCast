class DailyFeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  DailyFeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory DailyFeelsLike.fromJson(Map<String, dynamic> json) => DailyFeelsLike(
        day: json['day'].toDouble(),
        night: json['night'].toDouble(),
        eve: json['eve'].toDouble(),
        morn: json['morn'].toDouble(),
      );
}
