import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/DoctorBookingsController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Widgets/DoctorDetailWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../../Widgets/CustomAppBar.dart';

class DoctorUpcomingBookingDetails extends StatefulWidget {
  DoctorUpcomingBookingDetails({super.key, required this.bookingType});

  final String bookingType;

  @override
  State<DoctorUpcomingBookingDetails> createState() =>
      _DoctorUpcomingBookingDetailsState();
}

class _DoctorUpcomingBookingDetailsState
    extends State<DoctorUpcomingBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.3),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: SvgPicture.asset(
            "lib/Assets/Images/BackButton.svg",
            fit: BoxFit.scaleDown,
            color: Colors.black,
          ),
        ),
        title: TextStyleInterForSplash(
          text: Strings.upcoming,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
        titleSpacing: -20.0,
        // Adjust this value to reduce the gap
        toolbarHeight: 50,
        centerTitle: false,
        actions: [],
        elevation: 3,
        scrolledUnderElevation: 3.0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: DoctorDetailWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SubmitButtonWidget(
                  image: "lib/Assets/Images/videocall.svg",
                  text: 'Join',
                  onTap: () {

                },),
              ),
              SizedBox(height: 10),
              TextStyleInterForSplash(
                text: Strings.appointmentdetails,
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
                        text2: Strings.date,
                        showInfoButton: false,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ShiftDetailsWidget(
                        text1: "09:00 AM - 09:30 AM",
                        text2: Strings.time,
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
                        text1: "Merlin Joy",
                        text2: Strings.patient,
                        showInfoButton: false,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ShiftDetailsWidget(
                        text1:
                            widget.bookingType == "home"
                                ? "Request Home Visit"
                                : "Video Consult",
                        text2: Strings.consultType,
                        showInfoButton: false,
                      ),
                    ),
                  ],
                ),
              ), SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.invoicenumber,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 15.00,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStyleInterForSplash(
                    text: "987654321",
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    size: 14.00,
                  ),
                  TextStyleInterForSplash(
                    text: Strings.downloadinvoice,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    size: 13.00,
                    decoration: TextDecoration.underline,
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                      text: Strings.consultationFee,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      size: 14.00,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextStyleInterForSplash(
                        text: "₹500",
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
                      text: Strings.servicesFee,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      size: 14.00,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextStyleInterForSplash(
                        text: "₹12",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 14.00,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextStyleInterForSplash(
                      text: Strings.totalPayable,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      size: 14.00,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextStyleInterForSplash(
                        text: "₹512",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 14.00,
                      ),
                    ),
                  ),
                ],
              ),
              widget.bookingType == "home" ? Container() : SizedBox(height: 15),
              widget.bookingType == "home"
                  ? Container()
                  : widget.bookingType == "home"
                  ? Container()
                  : SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
