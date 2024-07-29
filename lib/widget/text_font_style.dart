import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFontStyle extends StatelessWidget {
  final String data;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final bool isUnderline;
  final TextAlign textAlign;

  const TextFontStyle(
    this.data, {
    super.key,
    this.color,
    this.size,
    this.weight,
    this.overflow,
    this.isUnderline = false,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontFamily: GoogleFonts.kanit().fontFamily,
        overflow: overflow,
        decoration: isUnderline ? TextDecoration.underline : null,
      ),
      textAlign: textAlign,
    );
  }
}
