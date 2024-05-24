import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  final String data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const ShadowText({
    super.key,
    required this.data,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.white,
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 3.0,
            color: Color.fromARGB(32, 0, 0, 0),
          ),
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 8.0,
            color: Color.fromARGB(32, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
