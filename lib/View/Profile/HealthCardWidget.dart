import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';

import '../../Widgets/widgets.dart' show TextStyleInterForSplash, TextStyleInterWithoutPadding;

class HealthCardWidget extends StatelessWidget {
  const HealthCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("lib/Assets/Images/healthCardIcon.svg",fit: BoxFit.scaleDown,) ,// Example child in nested row
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleInterWithoutPadding(
                    textAlign: TextAlign.start,
                    text: Strings.healthCard,
                    color: blackTextColor2,
                    fontWeight: FontWeight.w700,
                    size: 16.00,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: TextStyleInterWithoutPadding(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'Securely store medical documents, family records and doctor consultations.',
                          color: greyText,
                          fontWeight: FontWeight.w400,
                          size: 11.00,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}