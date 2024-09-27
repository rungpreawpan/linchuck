import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lin_chuck/constant/value_constant.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;
  final double fontSize;
  final double padding;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16.0,
    this.textColor,
    this.fontSize = 16.0,
    this.padding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: padding),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontFamily: GoogleFonts.kanit().fontFamily,
          ),
        )
      ],
    );
  }
}