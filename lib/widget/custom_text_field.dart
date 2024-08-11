import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lin_chuck/constant/value_constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final int maxLine;
  final int? maxLength;
  final TextInputType inputType;
  final bool obscureText;
  final void Function(String)? onChanged;
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
  final String? helperText;
  final Widget? prefix;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    this.textEditingController,
    this.maxLine = 1,
    this.maxLength,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
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
    this.helperText,
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
      inputFormatters: inputType == TextInputType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : [],
      textInputAction: TextInputAction.done,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSizeL,
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      onChanged: onChanged,
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
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1.0,
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
        helperText: helperText,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
