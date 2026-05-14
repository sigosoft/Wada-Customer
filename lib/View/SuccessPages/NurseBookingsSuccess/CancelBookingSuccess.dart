import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import '../../../Resource/Strings.dart';
import '../../Home/HomeNurseDetailsWidget.dart';
import '../../Login/SubmitButtonWidget.dart';

class CancelBookingSuccess extends StatelessWidget {
  final Map<String, dynamic>? data;
  const CancelBookingSuccess({super.key, this.data});

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
                    "lib/Assets/Images/canceltick.svg",
                    width: 140,
                    height: 140,
                  ),
                  SizedBox(height: 10),
                  Text(
                    Strings.cancelledSuccessful,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    Strings.shiftCancelledMessage,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  HomeNurseDetailsWidget(
                    showButton: false,
                    buttonText: "",
                    name: data?['name']?.toString() ?? "Nurse Name",
                    location: data?['location']?.toString() ?? "Location",
                    qualification:
                        data?['qualification']?.toString() ?? "Qualification",
                    experience: "${data?['experience'] ?? 0} Years of Experience",
                    checkInDate: data?['checkin_date'] ?? "",
                    checkInTime: data?['checkin_time'] ?? "",
                    languages:
                        (data?['languages'] as List?)?.join(", ") ??
                        "Languages",
                    imagePath:
                        (data?['image'] != null &&
                                data!['image'].toString().isNotEmpty)
                            ? "${ApiConfigs.IMAGE_URL}${data!['image']}"
                            : 'lib/Assets/Images/nurse.png',
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
          SizedBox(height: 30),
        ],
      ),
    );
  }
}