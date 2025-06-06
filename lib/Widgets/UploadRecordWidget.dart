import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class UploadRecordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [15, 5],
          strokeWidth: 1,
          color: colorPrimary,
          radius: Radius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: 130,
          color: Color(0xFFEAF3FA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/Assets/Images/uploadrecord.svg',
                width: 45,
                height: 45,
              ),
              SizedBox(height: 10),
              Text(
                'Select File',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: blackTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}