import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;
  const AppText({
    Key? key,
    required this.text,
    this.size = 14,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
