import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class FamilyCardRowWidget extends StatelessWidget {
  final dynamic heading;
  final dynamic subText;
  final dynamic width;

  const FamilyCardRowWidget({
    super.key,
    this.heading,
    this.subText,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextStyleInterWithoutPadding(
              textAlign: TextAlign.center,
              text: subText,
              maxLines: 3,
              color: blackTextColor2,
              fontWeight: FontWeight.w600,
              size: 14.00,
            ),
            TextStyleInterWithoutPadding(
              text: heading,
              color: greyText,
              fontWeight: FontWeight.w400,
              size: 12.00,
            ),
          ],
        ),
      ),
    );
  }
}