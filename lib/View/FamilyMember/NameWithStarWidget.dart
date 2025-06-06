
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Resource/Colors.dart';

class NameWithStarWidget extends StatelessWidget {
  final dynamic name;
  final dynamic isSelected;

  const NameWithStarWidget({
    super.key,this.name,this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSelected == true ? SvgPicture.asset(
            "lib/Assets/Images/familyMemberStarIcon.svg",
            fit: BoxFit.scaleDown) : SizedBox.shrink(),
        SizedBox(width: 4),
        TextStyleInterWithoutPadding(
          text: name,
          color: blackTextColor2,
          fontWeight: FontWeight.w700,
          size: 16.00,
        ),
      ],
    );
  }}