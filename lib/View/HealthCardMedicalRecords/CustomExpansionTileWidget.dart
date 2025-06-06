import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/AttachmentWidget.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/ExpansionTileSubtitleWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';


class CustomExpansionTileWidget extends StatelessWidget {
  const CustomExpansionTileWidget({
    super.key,
    required this.controller,
    this.name,
    this.notes,
    this.attachmentList
  });

  final dynamic controller;
  final dynamic name;
  final dynamic notes;
  final List<String>? attachmentList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.sizedBoxHeight =
        controller.sizedBoxHeight == 150.0 ?450.00: 150.0;
        controller.update();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: controller.sizedBoxHeight,
        decoration: BoxDecoration(
          color: colorPrimaryWith25Opacity,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextStyleInterWithoutPadding(
                  textAlign: TextAlign.start,
                  text: Strings.covid19Vaccination,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  size: 16.0,
                ),
                CircleAvatar(
                  backgroundColor: colorPrimary,
                  radius: 10,
                  child: Icon(
                    controller.sizedBoxHeight ==450?
                    Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 15, // Adjust size as needed
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ExpansionTileSubtitleWidget(name: name),
            SizedBox(height: 10),
            Visibility(
              visible: controller.sizedBoxHeight ==450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const TextStyleInterWithoutPadding(
                    textAlign: TextAlign.start,
                    text: Strings.notes,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    size: 16.0,
                  ),
                  const SizedBox(height: 10),
                  TextStyleInterWithoutPadding(
                    textAlign: TextAlign.start,
                    text: notes,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    size: 13.0,
                    height: 1.6,
                  ),
                  const SizedBox(height: 10),
                  const TextStyleInterWithoutPadding(
                    textAlign: TextAlign.start,
                    text: Strings.attachments,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    size: 16.0,
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        growable: true,
                        attachmentList!.length, (index) => AttachmentWidget(
                        image: attachmentList![index],
                      ),)
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: deleteIconBorder,
                          ),
                          height: 50,
                          width: 50,
                          child: SvgPicture.asset(
                            "lib/Assets/Images/deleteIconRed.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
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
          ],
        ),
      ),
    );
  }
}