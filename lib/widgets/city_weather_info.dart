import 'package:flutter/material.dart';
import 'package:sky_cast/widgets/weather_conditions/sunny_condition.dart';

class CityWeatherInfo extends StatefulWidget {
  const CityWeatherInfo({super.key});

  @override
  State<CityWeatherInfo> createState() => _CityWeatherInfoState();
}

class _CityWeatherInfoState extends State<CityWeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.11,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.07,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child:  ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: const SunnyCondition(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
