import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/BookingsController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Bookings/BookingTabBarItem2.dart';
import 'package:waada_customerapp/View/Bookings/BookingTabBarItem3.dart';
import 'package:waada_customerapp/View/Bookings/BookingsTabBarItem.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/HealthCardRowWidget.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';

import 'CustomTabBarWidget.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        label: Strings.bookings,
        showCloseIcon: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: BookingsController(),
            builder:
                (controller) => Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: HealthCardRowWidget(
                              text: Strings.nurseBookings,
                              textColor: controller.textColor1,
                              color: controller.boxColor1,
                              onTap: () {
                                controller.swapColors();
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: HealthCardRowWidget(
                              text: Strings.doctorBookings,
                              textColor: controller.textColor2,
                              color: controller.boxColor2,
                              onTap: () {
                                controller.swapColors();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CustomTabBarWidget(
                        tabs: const [
                          Tab(text: Strings.requests),
                          Tab(text: Strings.pending),
                          Tab(text: Strings.upcoming),
                          Tab(text: Strings.completed),
                          Tab(text: Strings.cancelled),
                        ],
                        tabViews: [
                          BookingsTabBarItem(
                            swapValue: controller.switchValue,
                            indexValue: 0,
                          ),
                          BookingsTabBarItem(
                            swapValue: controller.switchValue,
                            indexValue: 1,
                          ),
                          BookingsTabBarItem2(
                            swapValue: controller.switchValue,
                            indexValue: 2,
                          ),
                          BookingsTabBarItem3(
                            swapValue: controller.switchValue,
                            indexValue: 3,
                          ),
                          BookingsTabBarItem(
                            swapValue: controller.switchValue,
                            indexValue: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
