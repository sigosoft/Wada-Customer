import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleInterForSplash extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double size;
  final dynamic textAlign;
  final dynamic textOverFlow;
  final dynamic decoration;

  const TextStyleInterForSplash({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.color,
    required this.size,
    this.textAlign,
    this.textOverFlow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15),
      child: Text(
        text,
        overflow: textOverFlow,
        textAlign: textAlign,
        style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          decoration: decoration,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.2,
          height: 1.5,
        ),
      ),
    );
  }
}




class TextStyleInterWithoutPadding extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double size;
  final dynamic textAlign;
  final dynamic height;
  final int? maxLines;

  const TextStyleInterWithoutPadding({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.color,
    required this.size,
    this.textAlign,
    this.height,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        height: height ?? 0.00,
      ),
    );
  }
}
