import 'package:flutter/material.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class SubmitButton extends StatelessWidget {
  final dynamic width;
  final dynamic height;
  final dynamic color;
  final dynamic text;
  final dynamic textColor;

  const SubmitButton({
    super.key,this.width,this.height,this.color,this.text,this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: TextStyleInterWithoutPadding (
        text: text,
        color: textColor,
        fontWeight: FontWeight.w600,
        size: 13.00,
      ),
    );
  }
}
