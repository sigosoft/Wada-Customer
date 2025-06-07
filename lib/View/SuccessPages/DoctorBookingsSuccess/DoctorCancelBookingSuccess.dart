import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resource/Strings.dart';
import '../../Bookings/BookingDoctorDetailsWidget.dart';
import '../../Home/HomeNurseDetailsWidget.dart';
import '../../Login/SubmitButtonWidget.dart';


class DoctorCancelBookingSuccess extends StatelessWidget {
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
                      "lib/Assets/Images/canceltick.svg",
                      width: 140,
                      height: 140,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Cancel Booking Successful!",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your booking has been cancelled.",
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
              padding: const EdgeInsets.all(5.0),
              child: SubmitButtonWidget(
                onTap:(){
        
                },
                text:Strings.home,
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}