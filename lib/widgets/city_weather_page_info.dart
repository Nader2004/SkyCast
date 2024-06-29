import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_cast/models/city.dart';
import 'package:sky_cast/models/weather_data.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/shadow_text.dart';
import 'package:sky_cast/widgets/utils/weather_condition.dart';
import 'package:sky_cast/widgets/utils/weather_temprature.dart';
import 'package:sky_cast/widgets/weather_days_forecast.dart';

/// A page that displays detailed weather information for a specific city.
class CityWeatherInfoPage extends StatefulWidget {
  /// The city for which to display weather information.
  final City city;

  /// Creates a [CityWeatherInfoPage] widget.
  const CityWeatherInfoPage({super.key, required this.city});

  @override
  State<CityWeatherInfoPage> createState() => _CityWeatherInfoPageState();
}

class _CityWeatherInfoPageState extends State<CityWeatherInfoPage> {
  late SharedPreferences _prefs;
  late Future<WeatherData?> _initializedFuture;

  @override
  void initState() {
    initPrefs();
    fetchWeatherData();
    super.initState();
  }

  /// Fetches weather data for the specified city.
  void fetchWeatherData() async {
    _initializedFuture = WeatherApiService().fetchWeather(
      widget.city.lat,
      widget.city.lon,
    );
  }

  /// Initializes shared preferences.
  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.secondaryContainer,
      alignment: Alignment.center,
      child: FutureBuilder<WeatherData?>(
        future: _initializedFuture,
        builder: (context, snapshot) {
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
                child: SingleChildScrollView(
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
                              textAlign: TextAlign.center,
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
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ShadowText(
                              data: getWeatherTemprature(
                                  weatherData.current.temp, _prefs),
                              fontSize: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShadowText(
                                  data:
                                      'H: ${getWeatherTemprature(weatherData.daily[0].temp.max, _prefs)}',
                                  fontSize: 16,
                                ),
                                const SizedBox(width: 10),
                                ShadowText(
                                  data:
                                      'L: ${getWeatherTemprature(weatherData.daily[0].temp.min, _prefs)}',
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      WeatherDaysForecast(
                        weatherData: weatherData,
                        prefs: _prefs,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: 10,
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                            '/details',
                            arguments: {
                              'city': widget.city,
                              'weatherData': weatherData,
                              'prefs': _prefs,
                            },
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blueGrey),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.cloud_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'See more weather details',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
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
