import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/BookingsController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Bookings/BookingDoctorDetailsWidget.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorRequestCancelled.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorRequestsScreen.dart';
import 'package:waada_customerapp/View/DoctorBookings/DoctorUpcomingDetails.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsWidget.dart';
import 'package:waada_customerapp/View/NurseBookings/OngoingBookingDetails.dart';
import 'package:waada_customerapp/View/NurseBookings/PendingBookingDetails.dart';
import 'package:waada_customerapp/View/NurseBookings/UpcomingBookingDetails.dart';
import 'package:waada_customerapp/View/SuccessPages/DoctorBookingsSuccess/DoctorPaymentSuccess.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Widgets/DoctorDetailWidget.dart';
import '../DoctorBookings/DoctorBookingDetails.dart';
import '../VideoConsulting/VideoConsultingScreen.dart';

class BookingsTabBarItem2 extends StatelessWidget {
  final dynamic swapValue;
  final dynamic indexValue;

  const BookingsTabBarItem2({
    Key? key,
    required this.swapValue,
    required this.indexValue,
  }) : super(key: key);

  String _formatLanguages(dynamic languages) {
    if (languages == null) return "Languages";
    if (languages is String) return languages;
    if (languages is List) {
      return languages
          .map((l) {
            if (l is Map) return l['language'] ?? '';
            return l.toString();
          })
          .where((s) => s.isNotEmpty)
          .join(", ");
    }
    return "Languages";
  }

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

        if ((swapValue && bookings.isEmpty) || !swapValue) {
          return Center(
            child: Image.asset(
              'lib/Assets/Images/No bookings.png',
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.contain,
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
                    swapValue
                        ? InkWell(
                          onTap: () {
                            if (booking!['booking_status'].toString() == "4") {
                              Get.to(
                                OngoingBookingDetails(
                                  type: "ongoing",
                                  bookingId:
                                      booking['booking_id'] ?? booking['id'],
                                ),
                              );
                            } else {
                              Get.to(
                                UpcomingBookingDetails(
                                  bookingId:
                                      booking['booking_id'] ?? booking['id'],
                                ),
                              );
                            }
                          },
                          child: HomeNurseDetailsWidget(
                            showButton: false,
                            buttonText: "",
                            name: booking?['name'] ?? "Nurse Name",
                            location: booking?['location'] ?? "Location",
                            qualification:
                                booking?['qualification'] ?? "Qualification",
                            experience:
                                "${booking?['experience'] ?? 0} Years of Experience",
                            checkInDate: booking?['checkin_date'] ?? "",
                            checkInTime: booking?['checkin_time'] ?? "",
                            languages: _formatLanguages(booking?['languages']),
                          ),
                        )
                        : const SizedBox.shrink(),
                // InkWell(
                //     onTap: () {
                //       Get.to(
                //         DoctorUpcomingBookingDetails(
                //           bookingType: "home",
                //         ),
                //       );
                //     },
                //     child: BookingsDoctorDetailsWidget(
                //       showButton: true,
                //       buttonText: "Join",
                //     ),
                //   ),
              );
            },
          ),
        );
      },
    );
  }
}
