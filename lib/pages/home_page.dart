import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_cast/widgets/city_weather_info.dart';
import 'package:sky_cast/widgets/top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
