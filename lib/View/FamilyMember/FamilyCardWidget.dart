import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/FamilyMember/FamilyCardRowWidget.dart';
import 'package:waada_customerapp/View/FamilyMember/FamilyMemberScreen.dart';
import 'package:waada_customerapp/View/FamilyMember/NameWithStarWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class FamilyCardWidget extends StatelessWidget {
  final dynamic name;
  final dynamic gender;
  final dynamic dob;
  final dynamic phoneNo;
  final dynamic address;
  final dynamic relation;
  final VoidCallback? onDeleteTapped;
  final VoidCallback? onEditTapped;

  const FamilyCardWidget({
    super.key,
    this.name,
    this.relation,
    this.gender,
    this.dob,
    this.phoneNo,
    this.address,
    this.onDeleteTapped,
    this.onEditTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: borderLine,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            NameWithStarWidget(name: name, isSelected: true),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FamilyCardRowWidget(
                  width: MediaQuery.of(context).size.width * 0.30,
                  subText: relation,
                  heading: Strings.relationship,
                ),
                FamilyCardRowWidget(
                  width: MediaQuery.of(context).size.width * 0.30,
                  subText: gender,
                  heading: Strings.gender,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.20,
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Image.asset(
                    "lib/Assets/Images/qrImage.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FamilyCardRowWidget(
                  width: MediaQuery.of(context).size.width * 0.40,
                  subText: dob,
                  heading: Strings.dateOfBirth,
                ),
                FamilyCardRowWidget(
                  width: MediaQuery.of(context).size.width * 0.40,
                  subText: phoneNo,
                  heading: Strings.phoneNumber,
                ),
              ],
            ),
            SizedBox(height: 20),
            FamilyCardRowWidget(
              width: MediaQuery.of(context).size.width * 0.90,
              subText: address,
              heading: Strings.address,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onDeleteTapped,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: deleteIconBorder,
                    ),
                    height: 40,
                    width: 40,
                    child: SvgPicture.asset(
                      "lib/Assets/Images/deleteIconRed.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onEditTapped,
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: TextStyleInterWithoutPadding(
                      textAlign: TextAlign.center,
                      text: Strings.edit,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      size: 14.00,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}