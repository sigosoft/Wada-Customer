import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class DeleteAccountWidget extends StatelessWidget {
  final dynamic onTap;

  const DeleteAccountWidget({
    super.key,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: borderLine,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50,
          child: Row(
            children: [
              SvgPicture.asset(
                "lib/Assets/Images/deleteIcon.svg",
                fit: BoxFit.scaleDown,
                color: logoutTextColor,
              ),
              const SizedBox(width: 8.0),
              TextStyleInterForSplash(
                text:  Strings.deleteAccount,
                color: logoutTextColor,
                fontWeight: FontWeight.w400,
                size: 14.00,
              ),
            ],
          ),
        ),
      ),
    );
  }
}