import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class SubmitButtonWhite extends StatelessWidget {
  final dynamic amount;

  const SubmitButtonWhite({
    super.key,this.amount
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 70,
        width: double.infinity,
        alignment: Alignment.center,
        child: TextStyleInterWithoutPadding(
          text:"${Strings.pay}$amount/${Strings.year}",
          fontWeight: FontWeight.w600,
          color:colorPrimary,
          size: MediaQuery.of(context).size.width * 0.05,
        ),
      ),
    );
  }
}