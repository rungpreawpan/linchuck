import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lin_chuck/constant/value_constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final int maxLine;
  final int? maxLength;
  final TextInputType inputType;
  final bool obscureText;
  final bool isEnabled;
  final bool? isDense;
  final bool filled;
  final Color filledColor;
  final EdgeInsetsGeometry? padding;
  final String? labelText;
  final double labelFontSize;
  final Color labelFontColor;
  final String? hintText;
  final double hintFontSize;
  final Color hintFontColor;
  final Widget? prefix;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    this.textEditingController,
    this.maxLine = 1,
    this.maxLength,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.isEnabled = true,
    this.isDense,
    this.filled = true,
    this.filledColor = Colors.white,
    this.padding,
    this.labelText,
    this.labelFontSize = fontSizeM,
    this.labelFontColor = Colors.grey,
    this.hintText,
    this.hintFontSize = fontSizeM,
    this.hintFontColor = Colors.grey,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: inputType,
      textInputAction: TextInputAction.done,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSizeL,
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      decoration: InputDecoration(
        enabled: isEnabled,
        isDense: isDense,
        filled: filled,
        fillColor: filledColor,
        contentPadding: padding ??
            const EdgeInsets.symmetric(
              horizontal: marginX2,
              vertical: 10.0,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0.0,
            style: BorderStyle.none,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: labelFontSize,
          color: labelFontColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintFontSize,
          color: hintFontColor,
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
