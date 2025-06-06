import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/AttachmentWidget.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/ExpansionTileSubtitleWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class CustomExpansionTileWidgetForConsultationRecords extends StatelessWidget {
  const CustomExpansionTileWidgetForConsultationRecords({
    super.key,
    required this.controller,
    this.name,
    this.notes,
    this.attachmentList,
    this.doctorName,
  });

  final dynamic controller;
  final dynamic name;
  final dynamic notes;
  final List<String>? attachmentList;
  final dynamic doctorName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.sizedBoxHeight =
            controller.sizedBoxHeight == 150.0 ? 420.00 : 150.0;
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
                  text: "Dr. $doctorName",
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  size: 16.0,
                ),
                CircleAvatar(
                  backgroundColor: colorPrimary,
                  radius: 10,
                  child: Icon(
                    controller.sizedBoxHeight == 420
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
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
              visible: controller.sizedBoxHeight == 420.00,
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
                      attachmentList!.length,
                      (index) =>
                          AttachmentWidget(image: attachmentList![index]),
                    ),
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
