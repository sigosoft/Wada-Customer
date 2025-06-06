import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class BookNowButton extends StatelessWidget {
  final dynamic text;
  final dynamic onTap;

  const BookNowButton({
    super.key,this.text,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap:onTap ,
        child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child:  TextStyleInterForSplash(
            text: text,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            size: 16.00,
          ),
        ),
      ),
    );
  }
}
