import 'package:flutter/material.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/widgets/weather_conditions/cloud_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/rain_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/shower_sleet_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/snow_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/sunny_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/thunder_storm_condition.dart';

Widget getWeatherCondition(WeatherData weatherData) {
  switch (weatherData.current.weather.first.id) {
    case >= 200 && < 300: // thunderstorm
      return const ThunderstormCondition();
    case >= 300 && < 400: // shower sleet
      return const ShowerSleetCondition();
    case >= 500 && < 600: // rain
      return const RainCondition();
    case >= 600 && < 700: // snow
      return const SnowCondition();
    case >= 700 && < 800: // fog (wind)
      return const SizedBox();
    case 800: // clear
      return const SunnyCondition();
    case >= 801 && < 900: // clouds
      return const CloudCondition();
    default:
      return const SunnyCondition();
  }
}
