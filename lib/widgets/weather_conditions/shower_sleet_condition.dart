import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class ShowerSleetCondition extends StatelessWidget {
  const ShowerSleetCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
      isLeftCornerGradient: true,
      colors: [
        Color(0xff37474f),
        Color(0xff546e7a),
        Color(0xffbdbdbd),
        Color(0xff90a4ae),
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
        SnowWidget(
          snowConfig: SnowConfig(
              count: 30,
              size: 20,
              color: Color(0xb3ffffff),
              icon: IconData(57399, fontFamily: 'MaterialIcons'),
              widgetSnowflake: null,
              areaXStart: 21,
              areaXEnd: 195,
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
        RainWidget(
          rainConfig: RainConfig(
              count: 10,
              lengthDrop: 13,
              widthDrop: 4,
              color: Color(0x9978909c),
              isRoundedEndsDrop: true,
              widgetRainDrop: null,
              fallRangeMinDurMill: 500,
              fallRangeMaxDurMill: 1500,
              areaXStart: 160,
              areaXEnd: 150,
              areaYStart: 230,
              areaYEnd: 620,
              slideX: 2,
              slideY: 0,
              slideDurMill: 2000,
              slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
              fallCurve: Cubic(0.55, 0.09, 0.68, 0.53),
              fadeCurve: Cubic(0.95, 0.05, 0.80, 0.04)),
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
