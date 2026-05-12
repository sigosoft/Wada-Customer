import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import '../../../Resource/Strings.dart';
import '../../Home/HomeNurseDetailsWidget.dart';
import '../../Login/SubmitButtonWidget.dart';
import 'package:get/get.dart';
import '../../../Configs/ApiConfigs.dart';
import '../../../Controller/NurseBookingController.dart';

class RequestSentSuccess extends StatelessWidget {
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
                      Strings.requestSent,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<NurseBookingController>(
                      init: Get.find<NurseBookingController>(),
                      builder: (controller) {
                        final nurse = controller.nurseData;
                        return HomeNurseDetailsWidget(
                          showButton: false,
                          buttonText: "",
                          name: nurse?['name']?.toString() ?? "Nurse Name",
                          location:
                              nurse?['location']?.toString() ?? "Location",
                          languages:
                              (nurse?['languages'] as List?)
                                  ?.take(2)
                                  .map((l) => l['language'])
                                  .join(", ") ??
                              "Languages",
                          plusLanguages:
                              (nurse?['languages'] as List?) != null &&
                                      (nurse?['languages'] as List).length > 2
                                  ? (nurse?['languages'] as List)
                                      .skip(2)
                                      .map((l) => l['language'])
                                      .join(", ")
                                  : "",
                          qualification:
                              nurse?['qualification']?.toString() ??
                              "Qualification",
                          experience:
                              "${nurse?['experience'] ?? 0} Years of Experience",
                          imagePath:
                              (nurse?['image'] != null &&
                                      nurse!['image'].toString().isNotEmpty)
                                  ? "${ApiConfigs.IMAGE_URL}${nurse['image']}"
                                  : 'lib/Assets/Images/nurse.png',
                          checkInDate: controller.fromDate,
                          checkInTime: controller.checkinTimeController.text,
                        );
                      },
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
      ),
    );
  }
}
