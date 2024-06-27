import 'package:flutter/material.dart';

/// A widget that displays text with a shadow effect.
class ShadowText extends StatelessWidget {
  /// The text to display.
  final String data;

  /// The font size of the text.
  final double? fontSize;

  /// The font weight of the text.
  final FontWeight? fontWeight;

  /// The text alignment.
  final TextAlign? textAlign;

  /// Creates a [ShadowText] widget.
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
