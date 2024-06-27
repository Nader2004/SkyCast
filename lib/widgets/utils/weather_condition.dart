import 'package:flutter/material.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/widgets/weather_conditions/cloud_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/rain_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/shower_sleet_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/snow_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/sunny_condition.dart';
import 'package:sky_cast/widgets/weather_conditions/thunder_storm_condition.dart';

/// Returns the appropriate weather condition widget based on the current weather data.
///
/// The [weatherData] parameter is an instance of [WeatherData] which contains the current weather information.
///
/// This function uses the weather condition ID from the [weatherData] to determine the appropriate
/// weather condition widget to display.
///
/// Example:
/// ```dart
/// final weatherData = WeatherData(...);
/// final weatherConditionWidget = getWeatherCondition(weatherData); // Returns a weather condition widget based on the current weather
/// ```
Widget getWeatherCondition(WeatherData weatherData) {
  final int weatherId = weatherData.current.weather.first.id;

  if (weatherId >= 200 && weatherId < 300) {
    // Thunderstorm
    return const ThunderstormCondition();
  } else if (weatherId >= 300 && weatherId < 400) {
    // Shower sleet
    return const ShowerSleetCondition();
  } else if (weatherId >= 500 && weatherId < 600) {
    // Rain
    return const RainCondition();
  } else if (weatherId >= 600 && weatherId < 700) {
    // Snow
    return const SnowCondition();
  } else if (weatherId >= 700 && weatherId < 800) {
    // Fog (wind)
    return const SizedBox();
  } else if (weatherId == 800) {
    // Clear
    return const SunnyCondition();
  } else if (weatherId >= 801 && weatherId < 900) {
    // Clouds
    return const CloudCondition();
  } else {
    // Default to sunny if the condition is unknown
    return const SunnyCondition();
  }
}