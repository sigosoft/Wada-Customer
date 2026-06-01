import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/BookingsController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CheckboxWdget.dart';

class UpcomingBookingDetails extends StatefulWidget {
  final int bookingId;
  const UpcomingBookingDetails({super.key, required this.bookingId});

  @override
  State<UpcomingBookingDetails> createState() =>
      _UpcomingBookingDetailsState();
}

class _UpcomingBookingDetailsState extends State<UpcomingBookingDetails> {
  final BookingsController controller = Get.find<BookingsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchBookingDetails(widget.bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.upcoming, showCloseIcon: false),
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

            int totalDays = 1;
            if (details['checkin_date'] != null &&
                details['checkout_date'] != null) {
              try {
                final start = DateTime.parse(
                  details['checkin_date'].toString(),
                );
                final end = DateTime.parse(details['checkout_date'].toString());
                totalDays = end.difference(start).inDays + 1;
              } catch (e) {
                print("Error parsing dates in UpcomingBookingDetails: $e");
              }
            }

            final baseAmount =
                details['amount'] ??
                details['price'] ??
                controller.selectedBookingDetails?['price'] ??
                '0';

            final double dailyRate =
                double.tryParse(
                  baseAmount
                      .toString()
                      .replaceAll('₹', '')
                      .replaceAll(',', '')
                      .trim(),
                ) ??
                0.0;

            final apiTotalVal =
                details['total_amount'] ??
                details['total'] ??
                details['grand_total'] ??
                controller.selectedBookingDetails?['amount'] ??
                controller.selectedBookingDetails?['total_amount'] ??
                controller.selectedBookingDetails?['total'] ??
                controller.selectedBookingDetails?['grand_total'];

            double apiTotal = 0.0;
            if (apiTotalVal != null) {
              apiTotal =
                  double.tryParse(
                    apiTotalVal
                        .toString()
                        .replaceAll('₹', '')
                        .replaceAll(',', '')
                        .trim(),
                  ) ??
                  0.0;
            }

            double parsedAmount = apiTotal;
            if (parsedAmount <= 0 ||
                (parsedAmount == dailyRate && totalDays > 1)) {
              parsedAmount = dailyRate * totalDays;
            }

            final formattedAmount =
                parsedAmount == parsedAmount.toInt()
                    ? parsedAmount.toInt().toString()
                    : parsedAmount.toStringAsFixed(2);

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
                      text: Strings.bookingdetails,
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
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: details['shift_type'].toString() == '1'
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
                              text: ' ${patient?['dob'] != null ? (DateTime.now().year - DateTime.parse(patient!['dob']).year) : ""} (${patient?['gender'] == 1 ? "M" : "F"})',
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
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient?['mobile'] ?? '',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            patient?['address'] ?? details['address'] ?? '',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          if (details['landmark'] != null || details['city'] != null)
                            Text(
                              "${details['landmark'] ?? ''} ${details['city'] ?? ''}".trim(),
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
                      text: Strings.invoicenumber,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextStyleInterForSplash(
                            text: details['invoice_number'] ?? details['booking_id']?.toString() ?? details['id']?.toString() ?? "",
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            size: 13.00,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.topRight,
                            child: Text(
                              Strings.downloadinvoice,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            text: Strings.paymentmethod,
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
                              text: details['payment_method'] ?? "Online Transaction",
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
                            text: "${details['shift_type'].toString() == '1' ? '4' : details['shift_type'].toString() == '2' ? '8' : details['shift_type'].toString() == '3' ? '12' : '24'} hours shift${totalDays > 1 ? ' for $totalDays Days' : ''}",
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
                              text: "₹$formattedAmount",
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
                              text: "₹$formattedAmount",
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              size: 14.00,
                            ),
                          ),
                        ),
                      ],
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
