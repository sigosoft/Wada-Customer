import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/NurseBookings/RequestSending.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../../Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../../Widgets/MemberDropdownField.dart';
import '../../Widgets/TextInputWidget.dart';

class NurseBookingDetails extends StatefulWidget {
  const NurseBookingDetails({super.key});

  @override
  State<NurseBookingDetails> createState() => _NurseBookingDetailsState();
}

class _NurseBookingDetailsState extends State<NurseBookingDetails> {
  TextEditingController checkintimeController = TextEditingController();
  TextEditingController checkouttimeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkintimeController.text = "09:30 AM";
    checkouttimeController.text = "05:00 PM";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(label: Strings.details, showCloseIcon: false),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              NurseDetailsWidget(showPartiallyAvailable: true,),
              SizedBox(height: 10),
              TextStyleInterForSplash(
                text: Strings.shiftdetails,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Row(children: [
                  Expanded(child: ShiftDetailsWidget(text1: "08 Feb 2025",text2: Strings.checkindate,showInfoButton: false,)),
                  SizedBox(width: 10,),
                  Expanded(child: ShiftDetailsWidget(text1: "18 Feb 2025",text2: Strings.checkoutdate,showInfoButton: false,)),
                ],),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Row(children: [
                  Expanded(child: ShiftDetailsWidget(text1: "4 Hours",text2: Strings.shifttype,showInfoButton: true,)),
                  SizedBox(width: 10,),
                  Expanded(child:Container()),
                ],),
              ),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.time,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child:SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              controller: checkintimeController,
                              readOnly: true,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: Strings.checkintime,
                                labelStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: blackTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.access_time,
                                    color: Colors.black,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF3F3F3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              controller: checkouttimeController,
                              readOnly: true,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: Strings.checkouttime,
                                labelStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: blackTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.access_time,
                                    color: Colors.black,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF3F3F3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,top: 15,right: 15),
                child: Text(
                  Strings.choosePatient,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5, right: 5,top: 10),
                  child: MemberDropdownField()),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.selectserviceRequirement,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              CheckboxWdget(content: "Injection Services", size: 13, color: Colors.black,isChecked: false,),
              CheckboxWdget(content: "Wound Care and Dressing", size: 13, color: Colors.black,isChecked: false,),
              CheckboxWdget(content: "Catheter Care", size: 13, color: Colors.black,isChecked: false,),
              Container(
                  margin: EdgeInsets.only(left: 5, right: 5,top: 10),
                  child: TextInputWidget(label: Strings.notes,type: TextInputType.text,height: 80)),
              SizedBox(height: 30),
              SubmitButtonWidget(
                onTap:(){
                 Get.to(RequestSending());
                },
                text:Strings.confirm,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}




