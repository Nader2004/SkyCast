import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class WindyCondition extends StatelessWidget {
  const WindyCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
      sizeCanvas: Size(350, 540),
      isLeftCornerGradient: false,
      colors: [
        Color(0xff263238),
        Color(0xff78909c),
      ],
      children: [
        WindWidget(
          windConfig: WindConfig(
              width: 5,
              y: 208,
              windGap: 10,
              blurSigma: 6,
              color: Color(0xff607d8b),
              slideXStart: 0,
              slideXEnd: 350,
              pauseStartMill: 50,
              pauseEndMill: 6000,
              slideDurMill: 1000,
              blurStyle: BlurStyle.solid),
        ),
        WindWidget(
          windConfig: WindConfig(
              width: 7,
              y: 300,
              windGap: 15,
              blurSigma: 11,
              color: Color(0xff607d8b),
              slideXStart: 0,
              slideXEnd: 350,
              pauseStartMill: 3,
              pauseEndMill: 6000,
              slideDurMill: 1000,
              blurStyle: BlurStyle.solid),
        ),
        WindWidget(
          windConfig: WindConfig(
              width: 6,
              y: 300,
              windGap: 14,
              blurSigma: 8,
              color: Color(0xff607d8b),
              slideXStart: 0,
              slideXEnd: 500,
              pauseStartMill: 50,
              pauseEndMill: 6000,
              slideDurMill: 1000,
              blurStyle: BlurStyle.solid),
        ),
      ],
    );
  }
}
