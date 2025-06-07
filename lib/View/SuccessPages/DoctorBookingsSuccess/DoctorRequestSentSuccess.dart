import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Widgets/DoctorDetailWidget.dart';
import '../../../Resource/Strings.dart';
import '../../Bookings/BookingDoctorDetailsWidget.dart';
import '../../Home/HomeNurseDetailsWidget.dart';
import '../../Login/SubmitButtonWidget.dart';

class DoctorRequestSentSuccess extends StatefulWidget {
  const DoctorRequestSentSuccess({super.key, required this.bookingType, required this.msg});
  final  String bookingType;
  final  String msg;
  @override
  State<DoctorRequestSentSuccess> createState() => _DoctorRequestSentSuccessState();
}

class _DoctorRequestSentSuccessState extends State<DoctorRequestSentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "lib/Assets/Images/request_success.svg",
                      width: 140,
                      height: 140,
                    ),
                    SizedBox(height: 10),
                    Text(
                      Strings.successful,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.msg,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    BookingsDoctorDetailsWidget(
                      showButton: false,
                      buttonText: Strings.makePayment,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,),
              child: SubmitButtonWidget(
                onTap:(){
        
                },
                text:Strings.home,
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}