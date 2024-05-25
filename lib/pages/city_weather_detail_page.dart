import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/hourly.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/widgets/shadow_text.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';
import 'package:sky_cast/widgets/utils/weather_icon.dart';

class CityWeatherDetailPage extends StatelessWidget {
  final WeatherData weatherData;
  final City city;
  const CityWeatherDetailPage(
      {super.key, required this.weatherData, required this.city});

  Widget _buildWeatherDetail(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  double getCurrentPercentage(DateTime sunrise, DateTime sunset) {
    final DateTime now = DateTime.now();
    final int totalMinutes = sunset.difference(sunrise).inMinutes;
    final int elapsedMinutes = now.difference(sunrise).inMinutes;

    if (elapsedMinutes < 0) return 0.0;
    if (elapsedMinutes > totalMinutes) return 100.0;

    return (elapsedMinutes / totalMinutes) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch(weatherData.current.sunrise * 1000);
    final DateTime sunset =
        DateTime.fromMillisecondsSinceEpoch(weatherData.current.sunset * 1000);

    final DateTime now = DateTime.now();

    final Duration totalDaylight = sunset.difference(sunrise);

    final Duration sinceSunrise = now.difference(sunrise);

    double percentage = sinceSunrise.inMinutes / totalDaylight.inMinutes;

    percentage = percentage.clamp(0, 1);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.7,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: getWeatherCondition(weatherData),
              ),
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      city.isMyLocation
                          ? const ShadowText(
                              data: 'My Location',
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            )
                          : const SizedBox.shrink(),
                      ShadowText(
                        data: city.name,
                        fontSize: city.isMyLocation ? 20 : 35,
                        fontWeight: city.isMyLocation
                            ? FontWeight.w500
                            : FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShadowText(
                    data: weatherData.daily[0].summary,
                    textAlign: TextAlign.center,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ShadowText(
                        data:
                            '${(weatherData.current.temp - 273.15).round()}°C',
                        fontSize: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShadowText(
                            data:
                                'H: ${(weatherData.daily[0].temp.max - 273.15).round()}°C',
                            fontSize: 16,
                          ),
                          const SizedBox(width: 10),
                          ShadowText(
                            data:
                                'L: ${(weatherData.daily[0].temp.min - 273.15).round()}°C',
                            fontSize: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[600]!.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey[500]!,
                            width: 1,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weatherData.hourly.length,
                                itemBuilder: (context, index) {
                                  final Hourly hourlyData =
                                      weatherData.hourly[index];

                                  final DateTime date =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          hourlyData.dt * 1000);

                                  final String hour =
                                      DateFormat('HH').format(date);

                                  final int tempCelsius =
                                      (hourlyData.temp - 273.15).round();

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: getWeatherIcon(
                                            hourlyData.weather[0].icon,
                                          ),
                                          height: 40,
                                          width: 40,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          hour,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '$tempCelsius°C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          MdiIcons.weatherSunsetUp,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          DateFormat('HH:mm').format(sunrise),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                      child: ArcProgressBar(
                                        percentage: getCurrentPercentage(sunrise, sunset),
                                        arcThickness: 3,
                                        animateFromLastPercent: true,
                                        handleSize: 8,
                                        backgroundColor: Colors.black12,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          MdiIcons.weatherSunsetDown,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          DateFormat('HH:mm').format(sunset),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildWeatherDetail(
                                        'Feels like',
                                        '${(weatherData.current.feelsLike - 273.15).round()}°C',
                                      ),
                                      _buildWeatherDetail(
                                        'Humidity',
                                        '${weatherData.current.humidity}%',
                                      ),
                                      _buildWeatherDetail(
                                        'Wind',
                                        '${weatherData.current.windSpeed.round()}Km/h',
                                      ),
                                      _buildWeatherDetail(
                                        'Pressure',
                                        '${weatherData.current.pressure}hPa',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Further Information'),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.08,
                color: Colors.grey[600]!.withOpacity(0.3),
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () => Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        ),
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
