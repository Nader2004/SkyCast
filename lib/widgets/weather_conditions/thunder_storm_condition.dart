import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class ThunderstormCondition extends StatelessWidget {
  const ThunderstormCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
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
        RainWidget(
          rainConfig: RainConfig(
              count: 40,
              lengthDrop: 13,
              widthDrop: 4,
              color: Color(0x9978909c),
              isRoundedEndsDrop: true,
              widgetRainDrop: null,
              fallRangeMinDurMill: 500,
              fallRangeMaxDurMill: 1500,
              areaXStart: 41,
              areaXEnd: 264,
              areaYStart: 208,
              areaYEnd: 620,
              slideX: 2,
              slideY: 0,
              slideDurMill: 2000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              fallCurve: Cubic(0.55, 0.09, 0.68, 0.53),
              fadeCurve: Cubic(0.95, 0.05, 0.80, 0.04)),
        ),
        ThunderWidget(
          thunderConfig: ThunderConfig(
              thunderWidth: 11,
              blurSigma: 28,
              blurStyle: BlurStyle.solid,
              color: Color(0x99ffee58),
              flashStartMill: 50,
              flashEndMill: 300,
              pauseStartMill: 50,
              pauseEndMill: 6000,
              points: [Offset(110.0, 210.0), Offset(120.0, 240.0)]),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 250,
              color: Color(0xad90a4ae),
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
        WindWidget(
          windConfig: WindConfig(
              width: 7,
              y: 300,
              windGap: 15,
              blurSigma: 7,
              color: Color(0xff607d8b),
              slideXStart: 0,
              slideXEnd: 350,
              pauseStartMill: 50,
              pauseEndMill: 6000,
              slideDurMill: 1000,
              blurStyle: BlurStyle.solid),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
              size: 160,
              color: Color(0xb1607d8b),
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
