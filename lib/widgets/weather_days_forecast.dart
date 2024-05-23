import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/widgets/utils/weather_icon.dart';
import 'package:sky_cast/widgets/utils/wetather_days.dart';

class WeatherDaysForecast extends StatelessWidget {
  final WeatherData weatherData;
  const WeatherDaysForecast({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        children: [
          for (final weather in weatherData.daily)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: getWeatherIcon(
                      weather.weather[0].icon,
                    ),
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    getWeatherDayName(weather),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${(weather.temp.day - 273.15).round()}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
