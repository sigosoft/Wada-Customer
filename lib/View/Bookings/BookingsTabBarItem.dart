import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/BookingsController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
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
    return GetBuilder<BookingsController>(
      builder: (controller) {
        final bookings = controller.getBookingsForIndex(indexValue as int);

        if (controller.isNurseLoading && controller.currentPage == 1) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: colorPrimary,
                  strokeWidth: 3,
                ),
              ),
            ),
          );
        }

        if (swapValue && bookings.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
            ),
            child: const Center(
              child: Text(
                "No bookings found",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !controller.isLoadMore &&
                swapValue) {
              controller.loadMoreNurseBookings();
            }
            return false;
          },
          child: ListView.builder(
            itemCount:
                (swapValue ? bookings.length : 1) +
                (controller.isLoadMore && swapValue ? 1 : 0),
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) {
              if (swapValue && index == bookings.length) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: colorPrimary,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                );
              }

              final booking = swapValue ? bookings[index] : null;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0 && indexValue == 0)
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
                      child: TextStyleInterForSplash(
                        textAlign: TextAlign.left,
                        text: Strings.pending,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 14.00,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child:
                        swapValue
                            ? InkWell(
                              onTap: () {
                                if (indexValue == 0)
                                  Get.to(
                                    PendingBookingDetails(
                                      bookingId: booking!['booking_id'],
                                    ),
                                  );
                                else if (indexValue == 3)
                                  Get.to(
                                    OngoingBookingDetails(type: "cancelled"),
                                  );
                              },
                              child: HomeNurseDetailsWidget(
                                showButton: false,
                                buttonText: "",
                                name: booking?['name'] ?? "Nurse Name",
                                location: booking?['location'] ?? "Location",
                                qualification:
                                    booking?['qualification'] ??
                                    "Qualification",
                                experience:
                                    "${booking?['experience'] ?? 0} Years of Experience",
                                checkInDate: booking?['checkin_date'] ?? "",
                                checkInTime: booking?['checkin_time'] ?? "",
                                languages:
                                    (booking?['languages'] as List?)?.join(
                                      ", ",
                                    ) ??
                                    "Languages",
                              ),
                            )
                            : InkWell(
                              onTap: () {
                                if (indexValue == 3) {
                                  Get.to(
                                    DoctorsRequestCancelledScreen(
                                      bookingType: 'home',
                                    ),
                                  );
                                }
                              },
                              child: BookingsDoctorDetailsWidget(
                                showButton: false,
                                buttonText: Strings.makePayment,
                              ),
                            ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
