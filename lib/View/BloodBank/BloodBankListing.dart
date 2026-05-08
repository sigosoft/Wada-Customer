import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/BloodBank/DonateBlood.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/widgets.dart';
import 'BloodBankItem.dart';

import 'package:waada_customerapp/Controller/BloodBankController.dart';

class BloodBankListing extends StatelessWidget {
  const BloodBankListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          text: Strings.bloodBank,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
        titleSpacing: -20.0, // Adjust this value to reduce the gap
        toolbarHeight: 50,
        centerTitle: false,
        actions: [
          SizedBox(
            width: 150,
            height: 40,
            child: SubmitButtonWidget(
              onTap: () {
                Get.to(DonateBlood());
              },
              text: Strings.donateblood,
            ),
          ),
          const SizedBox(width: 10),
        ],
        elevation: 3,
        scrolledUnderElevation: 3.0,
      ),
      body: GetBuilder<BloodBankController>(
        init: BloodBankController(),
        builder:
            (controller) => Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              color: Colors.white,
              child:
                  controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : controller.donors.isEmpty
                      ? const Center(child: Text("No donors found"))
                      : ListView.builder(
                        itemCount: controller.donors.length,
                        itemBuilder: (context, index) {
                          return BloodBankItem(donor: controller.donors[index]);
                        },
                      ),
            ),
      ),
    );
  }
}
