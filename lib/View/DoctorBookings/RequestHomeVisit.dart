import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import '../../../Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/CallAssistantButton.dart';
import '../../Widgets/DatePicker.dart';
import '../../Widgets/DoctorDetailWidget.dart';
import '../../Widgets/MemberDropdownField.dart';
import 'BookingDetails.dart';

class RequestHomeVisit extends StatefulWidget {
  const RequestHomeVisit({super.key});

  @override
  State<RequestHomeVisit> createState() => _RequestHomeVisitState();
}

class _RequestHomeVisitState extends State<RequestHomeVisit> {
  bool isTimeFieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.requesthomevisit, showCloseIcon: false),
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
                  Strings.chooseDateAndTime,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              DatePicker(),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          enabled: isTimeFieldEnabled,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3), // #F3F3F380 with 50% opacity
                            hintText: Strings.time,
                            hintStyle: GoogleFonts.inter(
                              fontSize: 13,
                              color: isTimeFieldEnabled?blackTextColor:greyTextColour4,
                              fontWeight: FontWeight.w400,
                            ),
                            suffixIcon: Icon(Icons.access_time,color: isTimeFieldEnabled?Colors.black:greyTextColour4,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          enabled: isTimeFieldEnabled,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3F3F3), // #F3F3F380 with 50% opacity
                            hintText: Strings.time,
                            hintStyle: GoogleFonts.inter(
                              fontSize: 13,
                              color: isTimeFieldEnabled?blackTextColor:greyTextColour4,
                              fontWeight: FontWeight.w400,
                            ),
                            suffixIcon: Icon(Icons.access_time,color: isTimeFieldEnabled?Colors.black:greyTextColour4,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex:1,
                      child: Text(
                        Strings.homeTimeRange,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          activeTrackColor: colorPrimary,
                          inactiveTrackColor: greyTextColour2,
                          inactiveThumbColor: colorPrimary,
                          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                          value: isTimeFieldEnabled,
                          onChanged: (value) {
                            setState(() {
                              isTimeFieldEnabled = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Text(
                  Strings.requestHomeVisitNote,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: red,
                  ),
                ),
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5 ),
                child: SubmitButtonWidget(
                  onTap: () {
                    Get.to(BookingDetails(
                      bookingType: "home"));
                  },
                  text: Strings.confirm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}