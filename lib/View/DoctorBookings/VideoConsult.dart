import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import '../../../Widgets/CustomAppBar.dart';
import '../../Widgets/CallAssistantButton.dart';
import '../../Widgets/DoctorDetailWidget.dart';
import '../../Widgets/MemberDropdownField.dart';
import 'BookingDetails.dart';
import 'DateSlotSelector.dart';

class VideoConsult extends StatefulWidget {
  const VideoConsult({super.key});

  @override
  State<VideoConsult> createState() => _VideoConsultState();
}

class _VideoConsultState extends State<VideoConsult> {
  bool isTimeFieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.videoconsult, showCloseIcon: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10,top: 10),
                  child: DoctorDetailWidget()),
              CallAssistantButton(
                onPressed: () {
                  // Your onPressed logic here
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10),
                child: Text(
                  Strings.choosePatient,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              MemberDropdownField(),
              Container(
                margin: EdgeInsets.only(left: 10,top: 15),
                child: Text(
                  Strings.chooseSlot,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              DateSlotSelector(),
              SizedBox(height: 20),
              SubmitButtonWidget(
                onTap: () {
                  Get.to(BookingDetails(
                      bookingType: "video"));
                },
                text: Strings.confirm,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}