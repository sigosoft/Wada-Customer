import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/Home/Home.dart';

import '../../../Resource/Strings.dart';
import '../../Bookings/BookingDoctorDetailsWidget.dart';
import '../../Home/HomeNurseDetailsWidget.dart';
import '../../Login/SubmitButtonWidget.dart';

class DoctorPaymentSuccess extends StatelessWidget {
  final Map<String, dynamic>? doctorData;
  final Map<String, dynamic>? bookingData;

  const DoctorPaymentSuccess({super.key, this.doctorData, this.bookingData});

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
                      Strings.paymentSuccess,
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
                      doctorData: doctorData,
                      bookingData: bookingData,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SubmitButtonWidget(
                onTap: () {
                  Get.offAll(() => const Home());
                },
                text: Strings.home,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
