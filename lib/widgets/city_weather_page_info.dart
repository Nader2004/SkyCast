import 'package:flutter/material.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/shadow_text.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';
import 'package:sky_cast/widgets/weather_days_forecast.dart';

class CityWeatherInfoPage extends StatefulWidget {
  final City city;
  const CityWeatherInfoPage({super.key, required this.city});

  @override
  State<CityWeatherInfoPage> createState() => _CityWeatherInfoPageState();
}

class _CityWeatherInfoPageState extends State<CityWeatherInfoPage> {
  late Future<WeatherData> _initializedFuture;

  @override
  void initState() {
    fetchWeatherData();
    super.initState();
  }

  void fetchWeatherData() async {
    _initializedFuture = WeatherApiService().fetchWeather(
      widget.city.lat,
      widget.city.lon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: FutureBuilder<WeatherData>(
          future: _initializedFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
              return const SizedBox.shrink();
            }

            final WeatherData weatherData = snapshot.data as WeatherData;

            return Stack(
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
                  top: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.city.isMyLocation
                                ? const ShadowText(
                                    data: 'My Location',
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  )
                                : const SizedBox.shrink(),
                            ShadowText(
                              data: widget.city.name,
                              fontSize: widget.city.isMyLocation ? 20 : 35,
                              fontWeight: widget.city.isMyLocation
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
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                      WeatherDaysForecast(weatherData: weatherData),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
