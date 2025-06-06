import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/RequestSentSuccess.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../../Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../../Widgets/CouponWidget.dart';

class RequestSending extends StatefulWidget {
  const RequestSending({super.key});

  @override
  State<RequestSending> createState() => _RequestSendingState();
}

class _RequestSendingState extends State<RequestSending> {

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
                  Expanded(child: ShiftDetailsWidget(text1: "09:30 AM",text2: Strings.checkintime,showInfoButton: false,)),
                ],),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Row(children: [
                  Expanded(child: ShiftDetailsWidget(text1: "08 Feb 2025",text2: Strings.checkoutdate,showInfoButton: false,)),
                  SizedBox(width: 10,),
                  Expanded(child: ShiftDetailsWidget(text1: "05:00 PM",text2: Strings.checkouttime,showInfoButton: false,)),
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
                text: Strings.patientdetails,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: RichText(
                  text: TextSpan(
                    text: 'Merlin Joy',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                    children: [
                      TextSpan(
                        text: ' 68 (F)',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 5),
            child: Text(
             '+91 987654321',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),),
          ),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.serviceRequirement,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              CheckboxWdget(content: "Wound Care and Dressing", size: 13, color: Colors.black,isChecked: true,),
              SizedBox(height: 5),
              TextStyleInterForSplash(
                text: Strings.notes,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              SizedBox(height: 5),
              TextStyleInterForSplash(
                text: Strings.dummy,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                size: 12.0,
              ),
              SizedBox(height: 10),
              CouponWidget(),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.billdetails,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextStyleInterForSplash(
                      text: "4 hours shift for 10 Days",
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      size: 14.00,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextStyleInterForSplash(
                        text: "₹4,000",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 14.00,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextStyleInterForSplash(
                      text: Strings.totalamount,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      size: 14.00,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextStyleInterForSplash(
                        text: "₹4,000",
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        size: 14.00,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              SubmitButtonWidget(
                onTap:(){
                  _showCancelShiftBottomSheet(context);
                },
                text:Strings.sendRequest,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              SvgPicture.asset(
                "lib/Assets/Images/sentrequest.svg",
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.sentRequest,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.sentrequestmsg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE7F4FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.no,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorPrimaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                         Get.to(RequestSentSuccess());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.yes,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}




