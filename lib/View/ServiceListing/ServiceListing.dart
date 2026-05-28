import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/BottomNavController.dart';
import 'package:waada_customerapp/Controller/HomeController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Home/OtherServicesGridWidget.dart';

import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/widgets.dart';

class ServiceListing extends StatefulWidget {
  const ServiceListing({super.key});

  @override
  State<ServiceListing> createState() => _ServiceListingState();
}

class _ServiceListingState extends State<ServiceListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Get.back();
            } else if (Get.isRegistered<BottomNavController>()) {
              Get.find<BottomNavController>().backToHome();
            }
          },
          child: SvgPicture.asset(
            "lib/Assets/Images/BackButton.svg",
            fit: BoxFit.scaleDown,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: TextStyleInterWithoutPadding(
          text: Strings.chooseYourService,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
        toolbarHeight: 50,
        elevation: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder:
                (controller) => SingleChildScrollView(
                  child: OtherServicesGrid(
                    otherServicesList: controller.otherServicesList,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
