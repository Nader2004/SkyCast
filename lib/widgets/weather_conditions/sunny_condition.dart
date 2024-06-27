import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

/// A widget that displays a sunny weather animation.
class SunnyCondition extends StatelessWidget {
  /// Creates a [SunnyCondition] widget.
  const SunnyCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
      colors: [
        Color(0xff64b5f6),
      ],
      children: [
        SunWidget(
          sunConfig: SunConfig(
            width: 262,
            blurSigma: 10,
            blurStyle: BlurStyle.solid,
            isLeftLocation: true,
            coreColor: Color(0xffffa726),
            midColor: Color(0xd6ffee58),
            outColor: Color(0xffff9800),
            animMidMill: 2000,
            animOutMill: 2000,
          ),
        ),
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
            blurStyle: BlurStyle.solid,
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0x65212121),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 20,
            y: 35,
            scaleBegin: 1,
            scaleEnd: 1.08,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 0,
            slideDurMill: 3000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 160,
            color: Color(0x77212121),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 140,
            y: 130,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 20,
            slideY: 4,
            slideDurMill: 2000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
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
            blurStyle: BlurStyle.solid,
          ),
        ),
      ],
    );
  }
}