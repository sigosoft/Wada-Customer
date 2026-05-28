import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide FormData;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Controller/BookingsController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/CancelBookingSuccess.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/PaymentSuccess.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Widgets/CheckboxWdget.dart';

class PendingBookingDetails extends StatefulWidget {
  final int bookingId;
  const PendingBookingDetails({super.key, required this.bookingId});

  @override
  State<PendingBookingDetails> createState() => _PendingBookingDetailsState();
}

class _PendingBookingDetailsState extends State<PendingBookingDetails> {
  final BookingsController controller = Get.find<BookingsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchBookingDetails(widget.bookingId);
    });
  }

  void _showCancelShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              SvgPicture.asset(
                "lib/Assets/Images/cancelshift.svg", // Replace with your SVG path
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.cancelbooking,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.cancelbookingmsg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE7F4FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.no,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorPrimaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.cancelBooking(widget.bookingId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.yes,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          text: Strings.bookingdetails,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
        titleSpacing: -20.0, // Adjust this value to reduce the gap
        toolbarHeight: 50,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: PopupMenuButton<int>(
              color: Colors.white,
              icon: Container(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  "lib/Assets/Images/settings.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
              onSelected: (value) {
                if (value == 1) {
                  _showCancelShiftBottomSheet(context);
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 1,
                      height: 30,
                      child: Text(
                        Strings.cancelshift,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
            ),
          ),
        ],
        elevation: 3,
        scrolledUnderElevation: 3.0,
      ),
      body: SafeArea(
        child: GetBuilder<BookingsController>(
          builder: (controller) {
            if (controller.isDetailsLoading) {
              return const Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: colorPrimary,
                    strokeWidth: 3,
                  ),
                ),
              );
            }
            final details =
                controller.selectedBookingDetails?['booking_details'];
            final patient =
                controller.selectedBookingDetails?['patient_details'];
            if (details == null) {
              return const Center(child: Text("No details found"));
            }
            return SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    NurseDetailsWidget(
                      showPartiallyAvailable: false,
                      nurseData: {
                        'name': details['name'],
                        'qualification': details['qualification'],
                        'experience': details['experience'],
                        'image': details['image'],
                        'location': details['location'],
                        'languages': details['languages'],
                      },
                    ),
                    const SizedBox(height: 10),
                    TextStyleInterForSplash(
                      text: Strings.shiftdetails,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: details['checkin_date'] ?? "",
                              text2: Strings.checkindate,
                              showInfoButton: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: details['checkin_time'] ?? "",
                              text2: Strings.checkintime,
                              showInfoButton: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: details['checkout_date'] ?? "",
                              text2: Strings.checkoutdate,
                              showInfoButton: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: details['checkout_time'] ?? "",
                              text2: Strings.checkouttime,
                              showInfoButton: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1:
                                  details['shift_type'].toString() == '1'
                                      ? "4 Hours"
                                      : details['shift_type'].toString() == '2'
                                      ? "8 Hours"
                                      : details['shift_type'].toString() == '3'
                                      ? "12 Hours"
                                      : "24 Hours",
                              text2: Strings.shifttype,
                              showInfoButton: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: details['booked_on'] ?? "",
                              text2: Strings.bookedon,
                              showInfoButton: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.patientdetails,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: RichText(
                        text: TextSpan(
                          text: patient?['name'] ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' ${patient?['dob'] != null ? (DateTime.now().year - DateTime.parse(patient!['dob']).year) : ""} (${patient?['gender'] == 1 ? "M" : "F"})',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                      ),
                      child: Text(
                        patient?['mobile'] ?? '',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.serviceRequirement,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    if (details['healthcare_categories'] != null)
                      ...(details['healthcare_categories'] as List).map(
                        (cat) => CheckboxWdget(
                          content: cat['category_name'] ?? "",
                          size: 13,
                          color: Colors.black,
                          isChecked: true,
                        ),
                      ),
                    const SizedBox(height: 5),
                    TextStyleInterForSplash(
                      text: Strings.notes,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 5),
                    TextStyleInterForSplash(
                      text: details['note'] ?? "No notes provided",
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 12.0,
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.billdetails,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextStyleInterForSplash(
                            text:
                                "${details['shift_type'].toString() == '1'
                                    ? '4'
                                    : details['shift_type'].toString() == '2'
                                    ? '8'
                                    : details['shift_type'].toString() == '3'
                                    ? '12'
                                    : '24'} hours shift",
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            size: 14.00,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: TextStyleInterForSplash(
                              text: "₹${details['amount'] ?? '0'}",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              size: 14.00,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextStyleInterForSplash(
                            text: Strings.totalamount,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            size: 14.00,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: TextStyleInterForSplash(
                              text: "₹${details['amount'] ?? '0'}",
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              size: 14.00,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SubmitButtonWidget(
                      onTap: () async {
                        print(
                          "--- Make Payment button clicked for ID: ${widget.bookingId} ---",
                        );
                        // Call API to update payment status
                        try {
                          final prefs = await SharedPreferences.getInstance();
                          final String? token = prefs.getString('auth_token');
                          String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.updateNursePaymentStatus}";
                          
                          final Map<String, dynamic> data = {'booking_id': widget.bookingId.toString()};
                          final dio_instance.FormData formData = dio_instance.FormData.fromMap(data);

                          print("--- [PendingBookingDetails] Request: POST $url ---");
                          
                          final response = await ApiConfigs.dio.post(
                            url,
                            data: formData,
                            options: dio_instance.Options(headers: {
                              'Accept': 'application/json',
                              if (token != null) 'Authorization': 'Bearer $token',
                            }),
                          );

                          print("--- [PendingBookingDetails] Response: ${response.statusCode} ---");
                          print("--- [PendingBookingDetails] Data: ${response.data} ---");
                        } catch (e) {
                          print("--- [PendingBookingDetails] API ERROR: $e ---");
                        }

                        Get.to(
                          PaymentSuccess(
                            data: {
                              'name': details['name'],
                              'location': details['location'],
                              'qualification': details['qualification'],
                              'experience': details['experience'],
                              'image': details['image'],
                              'checkin_date': details['checkin_date'],
                              'checkin_time': details['checkin_time'],
                              'languages':
                                  (details['languages'] as List?)
                                      ?.map((l) => (l is Map) ? l['language'] : l)
                                      .toList(),
                            },
                          ),
                        );
                      },
                      text: Strings.makePayment,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
