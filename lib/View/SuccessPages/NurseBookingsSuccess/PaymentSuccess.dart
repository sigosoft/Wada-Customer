import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resource/Strings.dart';
import '../../Home/HomeNurseDetailsWidget.dart';
import '../../Login/SubmitButtonWidget.dart';


class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                  HomeNurseDetailsWidget(showButton: false,buttonText: "",)
                ],
              ),
            ),
          ),
          Text(
            Strings.sharelocationnotes,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child:  SvgPicture.asset(
                    "lib/Assets/Images/homebutton.svg",
                    width: 40,
                    height: 50,
                  ),
                ),
                Expanded(
                  flex:4,
                  child: SubmitButtonWidget(
                    onTap:(){

                    },
                    text:Strings.sharelocation,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}