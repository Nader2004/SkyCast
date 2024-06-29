import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/services/database/city_database_service.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/shadow_text.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';
import 'package:sky_cast/widgets/utils/weather_temprature.dart';
import 'package:sky_cast/widgets/weather_days_forecast.dart';

/// A bottom sheet widget that displays weather information for a city
/// and allows the user to add or remove the city from their list.
class CityAdditionButtomSheet extends StatefulWidget {
  /// The city for which to display weather information.
  final City city;

  /// Callback function to perform an action when the city is added or removed.
  final VoidCallback action;

  /// Creates a [CityAdditionButtomSheet] widget.
  const CityAdditionButtomSheet({
    super.key,
    required this.city,
    required this.action,
  });

  @override
  State<CityAdditionButtomSheet> createState() =>
      _CityAdditionButtomSheetState();
}

class _CityAdditionButtomSheetState extends State<CityAdditionButtomSheet> {
  late Future<WeatherData?> _initializedFuture;
  late CityDatabaseService _cityDatabaseService;
  late SharedPreferences _prefs;
  final List<City> _cities = [];

  @override
  void initState() {
    initPrefs();
    fetchWeatherData();
    super.initState();
  }

  /// Initializes shared preferences and loads the list of saved cities.
  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _cityDatabaseService = CityDatabaseService.instance;
    _cityDatabaseService.readAll().then((value) {
      setState(() {
        _cities.addAll(value);
      });
    });
  }

  /// Fetches weather data for the specified city.
  void fetchWeatherData() async {
    _initializedFuture = WeatherApiService().fetchWeather(
      widget.city.lat,
      widget.city.lon,
    );
  }

  @override
  void dispose() {
    // _cityDatabaseService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: FutureBuilder<WeatherData?>(
        future: _initializedFuture,
        builder: (BuildContext context, AsyncSnapshot<WeatherData?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return LottieBuilder.asset(
              'assets/loading.json',
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            );
          }
          final WeatherData weatherData = snapshot.data as WeatherData;
          final city = widget.city;
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
                        child: const ShadowText(
                          data: 'Cancel',
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_cities.any((x) => x.name == city.name)) {
                            _cities.removeWhere((x) => x.name == city.name);
                            _cityDatabaseService.delete(city.name);
                            Navigator.of(context).pop(
                              {'city': widget.city, 'action': 'remove'},
                            );
                          } else {
                            _cities.add(city);
                            _cityDatabaseService.create(city);
                            Navigator.of(context).pop(
                              {'city': widget.city, 'action': 'add'},
                            );
                          }
                          widget.action();
                        },
                        child: ShadowText(
                          data: _cities.any((x) => x.name == city.name)
                              ? 'Remove'
                              : 'Add',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShadowText(
                        data: widget.city.name,
                        textAlign: TextAlign.center,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ShadowText(
                            data: getWeatherTemprature(
                              weatherData.current.temp,
                              _prefs,
                            ),
                            fontSize: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShadowText(
                                data: getWeatherTemprature(
                                  weatherData.daily[0].temp.max,
                                  _prefs,
                                ),
                                fontSize: 16,
                              ),
                              const SizedBox(width: 10),
                              ShadowText(
                                data: getWeatherTemprature(
                                  weatherData.daily[0].temp.min,
                                  _prefs,
                                ),
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShadowText(
                        data: weatherData.current.weather[0].description,
                        fontSize: 20,
                      ),
                    ),
                    WeatherDaysForecast(
                      weatherData: weatherData,
                      prefs: _prefs,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
