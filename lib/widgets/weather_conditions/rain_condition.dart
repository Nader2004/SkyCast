import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

/// A widget that displays a rain weather animation.
class RainCondition extends StatelessWidget {
  /// Creates a [RainCondition] widget.
  const RainCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return const WrapperScene(
      isLeftCornerGradient: true,
      colors: [
        Color(0xff424242),
        Color(0xffcfd8dc),
      ],
      children: [
        RainWidget(
          rainConfig: RainConfig(
            count: 30,
            lengthDrop: 13,
            widthDrop: 4,
            color: Color(0xff9e9e9e),
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
            fadeCurve: Cubic(0.95, 0.05, 0.80, 0.04),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 270,
            color: Color(0xcdbdbdbd),
            icon: IconData(63056, fontFamily: 'MaterialIcons'),
            widgetCloud: null,
            x: 119,
            y: -50,
            scaleBegin: 1,
            scaleEnd: 1.1,
            scaleCurve: Cubic(0.40, 0.00, 0.20, 1.00),
            slideX: 11,
            slideY: 13,
            slideDurMill: 4000,
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 250,
            color: Color(0x92fafafa),
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
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 160,
            color: Color(0xb5fafafa),
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
            slideCurve: Cubic(0.40, 0.00, 0.20, 1.00),
          ),
        ),
      ],
    );
  }
}