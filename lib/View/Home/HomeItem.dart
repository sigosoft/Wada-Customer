import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Controller/HomeController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Bookings/Bookings.dart';
import 'package:waada_customerapp/View/Home/CarouselSliderWidget.dart';
import 'package:waada_customerapp/View/Home/HomeAppBar.dart';
import 'package:waada_customerapp/View/Home/HomeHorizontalScrollingWidget.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsWidget.dart';
import 'package:waada_customerapp/View/Home/OtherServicesGridWidget.dart';
import 'package:waada_customerapp/View/Map/ChooseLocation.dart';
import 'package:waada_customerapp/View/NurseBookings/ShareLocationBookingDetails.dart';
import 'package:waada_customerapp/View/ServiceListing/ServiceListing.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({super.key});

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GetBuilder(
              init: HomeController(),
              builder:
                  (controller) =>
                      controller.isLoading
                          ? const SizedBox(
                            height: 300,
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              CarouselSliderWidget(
                                currentIndex: controller.currentIndex,
                                imageUrls: controller.imageUrls,
                                onPageChanged: (index) {
                                  setState(() {
                                    controller.currentIndex = index;
                                    controller.update();
                                  });
                                },
                              ),
                              const SizedBox(height: 5),
                              const TextStyleInterForSplash(
                                text: Strings.approved,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                size: 16.00,
                              ),
                              const SizedBox(height: 10),
                              if (controller.specializationsList.isNotEmpty)
                                ...controller.specializationsList.map((spec) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => ShareLocationBookingDetails(),
                                        );
                                      },
                                      child: HomeNurseDetailsWidget(
                                        name:
                                            spec['specialist']?.toString() ??
                                            "Specialist",
                                        qualification:
                                            spec['specialization']
                                                ?.toString() ??
                                            "Qualification",
                                        imagePath:
                                            spec['image'] != null
                                                ? "${ApiConfigs.IMAGE_URL}${spec['image']}"
                                                : 'lib/Assets/Images/nurse.png',
                                        onTapButton: () {
                                          Get.to(() => ChooseLocation());
                                        },
                                        showButton: true,
                                        buttonText: Strings.shareYourLocation,
                                      ),
                                    ),
                                  );
                                }).toList()
                              else
                                InkWell(
                                  onTap: () {
                                    Get.to(() => ShareLocationBookingDetails());
                                  },
                                  child: HomeNurseDetailsWidget(
                                    onTapButton: () {
                                      Get.to(() => ChooseLocation());
                                    },
                                    showButton: true,
                                    buttonText: Strings.shareYourLocation,
                                  ),
                                ),
                              const SizedBox(height: 15),
                              HomeHorizontalScrollingWidget(
                                screenList: controller.screenWidgets,
                                homeRowWidgetItems:
                                    controller.homeRowWidgetItems,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextStyleInterForSplash(
                                    text: Strings.otherServices,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    size: 16.00,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Handle view all action
                                      Get.to(() => ServiceListing());
                                    },
                                    child: const TextStyleInterForSplash(
                                      text: Strings.viewAll,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      size: 12.00,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              OtherServicesGrid(
                                otherServicesList: controller.otherServicesList,
                                onTap: () {},
                              ),
                              SizedBox(height: 15),
                              CarouselSliderWidget(
                                currentIndex: controller.currentIndex2,
                                imageUrls: controller.imageUrls2,
                                onPageChanged: (index) {
                                  setState(() {
                                    controller.currentIndex2 = index;
                                    controller.update();
                                  });
                                },
                              ),
                            ],
                          ),
            ),
          ),
        ),
      ),
    );
  }
}
