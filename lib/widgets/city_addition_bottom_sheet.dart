import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';

class CityAdditionButtomSheet extends StatefulWidget {
  final City city;
  final VoidCallback action;
  const CityAdditionButtomSheet(
      {super.key, required this.city, required this.action});

  @override
  State<CityAdditionButtomSheet> createState() =>
      _CityAdditionButtomSheetState();
}

class _CityAdditionButtomSheetState extends State<CityAdditionButtomSheet> {
  late Future<WeatherData> _initializedFuture;
  late SharedPreferences _prefs;
  List<String> _cities = [];

  @override
  void initState() {
    initPrefs();
    fetchWeatherData();
    super.initState();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _cities = _prefs.getStringList('cities') ?? [];
    });
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
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<WeatherData>(
        future: _initializedFuture,
        builder: (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
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
              Positioned(
                top: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_cities.contains(widget.city.name)) {
                            _cities.remove(widget.city.name);
                            _prefs.setStringList('cities', _cities);
                            Navigator.of(context).pop(
                              {'city': widget.city, 'action': 'remove'},
                            );
                          } else {
                            _cities.add(widget.city.name);
                            _prefs.setStringList('cities', _cities);
                            Navigator.of(context).pop(
                              {'city': widget.city, 'action': 'add'},
                            );
                          }
                          widget.action();
                        },
                        child: Text(
                          _cities.contains(widget.city.name) ? 'Remove' : 'Add',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.city.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${(weatherData.current.temp - 273.15).round()}°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          weatherData.current.weather[0].description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
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
                                    Text(
                                      '${DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000).day}/${DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000).month}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
