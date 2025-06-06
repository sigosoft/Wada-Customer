import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class SubmitButtonWidget extends StatelessWidget {
  final dynamic text;
  final VoidCallback onTap;

  const SubmitButtonWidget({
    super.key,this.text, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap:onTap ,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child:  FittedBox(
            fit: BoxFit.scaleDown, // Ensures text scales to fit
            child:   TextStyleInterForSplash(
              text: text,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 16.00,
            ),
          ),
        ),
      ),
    );
  }
}
