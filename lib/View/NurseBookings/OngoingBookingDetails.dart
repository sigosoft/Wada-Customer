import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/NurseBookings/ShiftLogs.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../Login/SubmitButtonWidget.dart';

class OngoingBookingDetails extends StatefulWidget {
  const OngoingBookingDetails({super.key, required this.type});
  final String type;
  @override
  State<OngoingBookingDetails> createState() =>
      _OngoingBookingDetailsState();
}

class _OngoingBookingDetailsState
    extends State<OngoingBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: widget.type=="cancelled"?Strings.cancelled:widget.type=="completed"?Strings.completed:Strings.ongoing, showCloseIcon: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                NurseDetailsWidget(showPartiallyAvailable: false),
                SizedBox(height: 5),
                widget.type=="cancelled"?Container():
                Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  child: SubmitButtonWidget(
                    onTap:(){
                      Get.to(ShiftLogs ());
                    },
                    text:Strings.shiftlogs,
                  ),
                ),
                SizedBox(height: 10),
                TextStyleInterForSplash(
                  text: widget.type=="cancelled"?Strings.shiftdetails:Strings.bookingdetails,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 15.00,
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: "08 Feb 2025",
                          text2: Strings.checkindate,
                          showInfoButton: false,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: "09:30 AM",
                          text2: Strings.checkintime,
                          showInfoButton: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: "08 Feb 2025",
                          text2: Strings.checkoutdate,
                          showInfoButton: false,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: "05:00 PM",
                          text2: Strings.checkouttime,
                          showInfoButton: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: "4 Hours",
                          text2: Strings.shifttype,
                          showInfoButton: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: "25 Jan 2025",
                          text2: Strings.bookedon,
                          showInfoButton: false,
                        ),
                      ),
                    ],
                  ),
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
                  margin: EdgeInsets.only(left: 15, right: 15),
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
                  margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '+91 987654321',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        'Raipur',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text(
                        '7J3H+2RG Raipur, Chhattisgarh',
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
                SizedBox(height: 15),
                TextStyleInterForSplash(
                  text: Strings.serviceRequirement,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 15.00,
                ),
                CheckboxWdget(
                  content: "Wound Care and Dressing",
                  size: 13,
                  color: Colors.black,
                  isChecked: true,
                ),
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
                SizedBox(height: 15),
                TextStyleInterForSplash(
                  text: Strings.invoicenumber,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 15.00,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextStyleInterForSplash(
                        text: "7569812345",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        size: 13.00,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.topRight,
                        child: Text(
                          Strings.downloadinvoice,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        text: Strings.paymentmethod,
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
                          text: "Wada Pay",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
