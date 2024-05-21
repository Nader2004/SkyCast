import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class SnowCondition extends StatelessWidget {
  const SnowCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
      isLeftCornerGradient: true,
      colors: [
        Color(0xff3949ab),
        Color(0xff90caf9),
        Color(0xffd6d6d6),
      ],
      children: [
        SnowWidget(
          snowConfig: SnowConfig(
              count: 30,
              size: 20,
              color: Color(0xb3ffffff),
              icon: IconData(57399, fontFamily: 'MaterialIcons'),
              widgetSnowflake: null,
              areaXStart: 42,
              areaXEnd: 240,
              areaYStart: 200,
              areaYEnd: 540,
              waveRangeMin: 20,
              waveRangeMax: 70,
              waveMinSec: 5,
              waveMaxSec: 20,
              waveCurve: Cubic(0.45, 0.05, 0.55, 0.95),
              fadeCurve: Cubic(0.60, 0.04, 0.98, 0.34),
              fallMinSec: 10,
              fallMaxSec: 60),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 250,
              color: Color(0xa8fafafa),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 20,
              y: 3,
              scaleBegin: 1,
              scaleEnd: 1.08,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 20,
              slideY: 0,
              slideDurMill: 3000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 160,
              color: Color(0xa8fafafa),
              icon: IconData(63056, fontFamily: 'MaterialIcons'),
              widgetCloud: null,
              x: 140,
              y: 97,
              scaleBegin: 1,
              scaleEnd: 1.1,
              scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              slideX: 20,
              slideY: 4,
              slideDurMill: 2000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00)),
        ),
      ],
    );
  }
}
