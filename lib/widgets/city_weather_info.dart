import 'package:flutter/material.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';

class CityWeatherInfo extends StatefulWidget {
  final City city;
  const CityWeatherInfo({super.key, required this.city});

  @override
  State<CityWeatherInfo> createState() => _CityWeatherInfoState();
}

class _CityWeatherInfoState extends State<CityWeatherInfo> {
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
      height: MediaQuery.of(context).size.height * 0.11,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<WeatherData>(
          future: _initializedFuture,
          builder: (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            final WeatherData weatherData = snapshot.data as WeatherData;
            return Stack(
              children: [
                Opacity(
                  opacity: 0.9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: getWeatherCondition(weatherData),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.city.isMyLocation
                                ? const Text(
                                    'My Location',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            Text(
                              widget.city.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: widget.city.isMyLocation ? 14 : 26,
                                fontWeight: widget.city.isMyLocation
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${(weatherData.current.temp - 273.15).round()}°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
