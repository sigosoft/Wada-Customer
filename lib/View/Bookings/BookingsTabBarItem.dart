import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Bookings/BookingDoctorDetailsWidget.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorRequestCancelled.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorRequestsScreen.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorUpcomingDetails.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorsBookingCompleted.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsWidget.dart';
import 'package:waada_customerapp/View/NurseBookings/OngoingBookingDetails.dart';
import 'package:waada_customerapp/View/NurseBookings/PendingBookingDetails.dart';
import 'package:waada_customerapp/View/NurseBookings/UpcomingBookingDetails.dart';
import 'package:waada_customerapp/View/SuccessPages/DoctorBookingsSuccess/DoctorPaymentSuccess.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Widgets/DoctorDetailWidget.dart';
import '../DoctorBookings/DoctorBookingDetails.dart';
import '../VideoConsulting/VideoConsultingScreen.dart';

class BookingsTabBarItem extends StatelessWidget {
  final dynamic swapValue;
  final dynamic indexValue;

  const BookingsTabBarItem({
    Key? key,
    required this.swapValue,
    required this.indexValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          indexValue == 0
              ? TextStyleInterForSplash(
                textAlign: TextAlign.center,
                text: Strings.pending,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: 14.00,
              )
              : Container(),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
                    swapValue
                        ? InkWell(
                          onTap: () {
                            indexValue == 0
                                ? Get.to(PendingBookingDetails())
                                : indexValue == 1
                                ? Get.to(UpcomingBookingDetails())
                                : indexValue == 2
                                ? Get.to(
                                  OngoingBookingDetails(type: "completed"),
                                )
                                : Get.to(
                                  OngoingBookingDetails(type: "cancelled"),
                                );
                          },
                          child: HomeNurseDetailsWidget(
                            showButton: false,
                            buttonText: "",
                          ),
                        )
                        : InkWell(
                          onTap: () {
                            indexValue == 1
                                ? Get.to(
                                  DoctorUpcomingBookingDetails(
                                    bookingType: "home",
                                  ),
                                )
                                : indexValue == 2
                                ? Get.to(
                                  DoctorsRequestScreen(bookingType: "home"),
                                )
                                : indexValue == 3
                                ? Get.to(
                                  DoctorsRequestCancelledScreen(
                                    bookingType: 'home',
                                  ),
                                )
                                : Get.to(
                                  DoctorsRequestCancelledScreen(
                                    bookingType: 'home',
                                  ),
                                );
                          },
                          child: BookingsDoctorDetailsWidget(
                            showButton: false,
                            buttonText: Strings.makePayment,
                          ),
                        ),
              );
            },
          ),
          SizedBox(height: 10),
          indexValue == 0
              ? TextStyleInterForSplash(
                textAlign: TextAlign.center,
                text: Strings.declined,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: 14.00,
              )
              : Container(),
          SizedBox(height: 10),
          indexValue == 0
              ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child:
                        swapValue
                            ? InkWell(
                              onTap: () {
                                Get.to(
                                  OngoingBookingDetails(type: "cancelled"),
                                );
                              },
                              child: HomeNurseDetailsWidget(
                                showButton: false,
                                buttonText: "",
                              ),
                            )
                            : BookingsDoctorDetailsWidget(
                              showButton: false,
                              buttonText: Strings.makePayment,
                            ),
                  );
                },
              )
              : Container(),
          SizedBox(height: 10),
          indexValue == 0
              ? TextStyleInterForSplash(
                textAlign: TextAlign.center,
                text: Strings.approved,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: 14.00,
              )
              : Container(),
          SizedBox(height: 10),
          indexValue == 0
              ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child:
                        swapValue
                            ? InkWell(
                              onTap: () {
                                Get.to(OngoingBookingDetails(type: ""));
                              },
                              child: HomeNurseDetailsWidget(
                                showButton: true,
                                buttonText: "Make Payment",
                              ),
                            )
                            : InkWell(
                              onTap: () {
                                Get.to(DoctorPaymentSuccess());
                              },
                              child: BookingsDoctorDetailsWidget(
                                showButton: true,
                                buttonText: Strings.makePayment,
                              ),
                            ),
                  );
                },
              )
              : Container(),
        ],
      ),
    );
  }
}
