import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import '../../../Resource/Strings.dart';
import '../../Login/SubmitButtonWidget.dart';

class PaymentCancelledScreen extends StatelessWidget {
  const PaymentCancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.offAll(() => const Home());
      },
      child: Scaffold(
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
                      "lib/Assets/Images/canceltick.svg",
                      width: 140,
                      height: 140,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Strings.paymentCancelled,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Strings.paymentCancelledMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SubmitButtonWidget(
                onTap: () {
                  Get.offAll(() => const Home());
                },
                text: Strings.home,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
