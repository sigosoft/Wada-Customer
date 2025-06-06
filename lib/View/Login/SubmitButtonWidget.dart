import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class SubmitButtonWidget extends StatelessWidget {
  final dynamic text;
  final VoidCallback onTap;
  final dynamic image;

  const SubmitButtonWidget({
    super.key,this.text, required this.onTap,this.image
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          fit: BoxFit.scaleDown,
          child:   Row(
            children: [
              TextStyleInterWithoutPadding(
                text: text,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                size: 16.00,
              ),
              SizedBox(width:image==null?0:5),
              image==null?SizedBox():SvgPicture.asset(image),
            ],
          ),
        ),
      ),
    );
  }
}
