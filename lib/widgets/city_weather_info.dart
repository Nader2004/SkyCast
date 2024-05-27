import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';
import 'package:sky_cast/widgets/utils/weather_temprature.dart';

class CityWeatherInfo extends StatefulWidget {
  final City city;
  final List<City> weatherCities;
  final int index;
  final VoidCallback onDelete;

  const CityWeatherInfo({
    super.key,
    required this.city,
    required this.weatherCities,
    required this.index,
    required this.onDelete,
  });

  @override
  State<CityWeatherInfo> createState() => _CityWeatherInfoState();
}

class _CityWeatherInfoState extends State<CityWeatherInfo> {
  late SharedPreferences _prefs;
  late Future<WeatherData> _initializedFuture;

  @override
  void initState() {
    initPrefs();
    fetchWeatherData();
    super.initState();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
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
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }
            final WeatherData weatherData = snapshot.data as WeatherData;
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                '/cities',
                arguments: {
                  'index': widget.index,
                  'weatherCities': widget.weatherCities,
                },
              ),
              child: Slidable(
                key: ValueKey(widget.city.name),
                endActionPane: widget.city.isMyLocation
                    ? null
                    : ActionPane(
                        dismissible: DismissiblePane(
                          onDismissed: () => widget.onDelete(),
                        ),
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => widget.onDelete(),
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ],
                      ),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.9,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
                                    fontSize:
                                        widget.city.isMyLocation ? 14 : 26,
                                    fontWeight: widget.city.isMyLocation
                                        ? FontWeight.w500
                                        : FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              getWeatherTemprature(
                                  weatherData.current.temp, _prefs),
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
                ),
              ),
            );
          }),
    );
  }
}
