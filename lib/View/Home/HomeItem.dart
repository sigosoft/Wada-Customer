import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Controller/HomeController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Bookings/Bookings.dart';
import 'package:waada_customerapp/View/Home/CarouselSliderWidget.dart';
import 'package:waada_customerapp/View/Home/HomeAppBar.dart';
import 'package:waada_customerapp/View/Home/HomeHorizontalScrollingWidget.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsWidget.dart';
import 'package:waada_customerapp/View/Home/OtherServicesGridWidget.dart';
import 'package:waada_customerapp/View/Map/ChooseLocation.dart';
import 'package:waada_customerapp/View/NurseBookings/UpcomingBookingDetails.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return RefreshIndicator(
              color: colorPrimary,
              onRefresh: controller.onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: width,
                  child:
                      controller.isLoading
                          ? const SizedBox(
                            height: 300,
                            child: const Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: colorPrimary,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
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
                              if (controller.approvedBookings.isNotEmpty) ...[
                                const TextStyleInterForSplash(
                                  text: Strings.approved,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  size: 16.00,
                                ),
                                const SizedBox(height: 10),
                                ...controller.approvedBookings.map((booking) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => UpcomingBookingDetails(
                                            bookingId:
                                                int.tryParse(
                                                  booking['booking_id']
                                                          ?.toString() ??
                                                      booking['id']
                                                          ?.toString() ??
                                                      '',
                                                ) ??
                                                0,
                                          ),
                                        );
                                      },
                                      child: HomeNurseDetailsWidget(
                                        name: booking['name'] ?? "Nurse Name",
                                        location:
                                            booking['location'] ?? "Location",
                                        qualification:
                                            booking['qualification'] ??
                                            "Qualification",
                                        experience:
                                            "${booking['experience'] ?? 0} Years of Experience",
                                        checkInDate:
                                            booking['checkin_date'] ?? "",
                                        checkInTime:
                                            booking['checkin_time'] ?? "",
                                        languages:
                                            (booking['languages'] as List?)
                                                ?.join(", ") ??
                                            "Languages",
                                        imagePath:
                                            booking['image'] != null
                                                ? "${ApiConfigs.IMAGE_URL}${booking['image']}"
                                                : 'lib/Assets/Images/nurse.png',
                                        onTapButton: () {
                                          Get.to(
                                            () => ChooseLocation(
                                              bookingId:
                                                  (booking['booking_id'] ??
                                                          booking['id'])
                                                      ?.toString(),
                                            ),
                                          );
                                        },
                                        showButton: true,
                                        buttonText: Strings.shareYourLocation,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                const SizedBox(height: 15),
                              ],
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
                                otherServicesList:
                                    controller.otherServicesList
                                        .take(3)
                                        .toList(),
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
            );
          },
        ),
      ),
    );
  }
}
