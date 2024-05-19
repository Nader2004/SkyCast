import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_cast/services/weather_api_service.dart';
import 'package:sky_cast/widgets/city_weather_info.dart';
import 'package:sky_cast/widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    fetchWeatherData();
    super.initState();
  }

  void fetchWeatherData() async {
   await WeatherApiService().fetchWeather(30.44, -94.04);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Theme.of(context).colorScheme.background),
      child: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: TopBar()),
                SliverList.builder(
                  itemBuilder: (context, index) => const CityWeatherInfo(),
                  itemCount: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
