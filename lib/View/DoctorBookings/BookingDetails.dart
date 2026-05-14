import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Controller/BookingsController.dart';
import 'package:waada_customerapp/Widgets/DoctorDetailWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../SuccessPages/DoctorBookingsSuccess/DoctorRequestSentSuccess.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({
    super.key,
    required this.bookingType,
    this.doctorData,
    this.bookingData,
  });
  final String bookingType;
  final dynamic doctorData;
  final dynamic bookingData;
  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  int selectedPaymentIndex = -1;

  final List<Map<String, String>> paymentMethods = [
    {"title": Strings.onlinepayment},
    {"title": Strings.wadapay},
  ];
  @override
  Widget build(BuildContext context) {
    String fee =
        widget.bookingType == "home"
            ? (widget.doctorData?['home_consultation_fee']?.toString() ?? "0")
            : (widget.doctorData?['video_consultation_fee']?.toString() ?? "0");

    double total = double.tryParse(fee) ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.bookingdetails, showCloseIcon: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: DoctorDetailWidget(doctorData: widget.doctorData),
                ),
                SizedBox(height: 10),
                TextStyleInterForSplash(
                  text: Strings.appointmentdetails,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 15.00,
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: widget.bookingData?['date'] ?? "08 Feb 2025",
                          text2: Strings.date,
                          showInfoButton: false,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1:
                              widget.bookingType == "home"
                                  ? "${widget.bookingData?['start_time'] ?? "09:00 AM"} - ${widget.bookingData?['end_time'] ?? "09:30 AM"}"
                                  : "09:00 AM - 09:30 AM",
                          text2: Strings.time,
                          showInfoButton: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1: widget.bookingData?['patient'] ?? "Merlin Joy",
                          text2: Strings.patient,
                          showInfoButton: false,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ShiftDetailsWidget(
                          text1:
                              widget.bookingType == "home"
                                  ? "Request Home Visit"
                                  : "Video Consult",
                          text2: Strings.consultType,
                          showInfoButton: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                TextStyleInterForSplash(
                  text: Strings.billdetails,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 15.00,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextStyleInterForSplash(
                        text: Strings.consultationFee,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        size: 14.00,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: TextStyleInterForSplash(
                          text: "₹$fee",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          size: 14.00,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextStyleInterForSplash(
                        text: Strings.totalPayable,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        size: 14.00,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: TextStyleInterForSplash(
                          text: "₹${total.toStringAsFixed(0)}",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          size: 14.00,
                        ),
                      ),
                    ),
                  ],
                ),
                widget.bookingType == "home"
                    ? Container()
                    : SizedBox(height: 15),
                widget.bookingType == "home"
                    ? Container()
                    : TextStyleInterForSplash(
                      text: Strings.paymentmethod,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                widget.bookingType == "home"
                    ? Container()
                    : SizedBox(height: 10),
                widget.bookingType == "home"
                    ? Container()
                    : Column(
                      children: List.generate(paymentMethods.length, (index) {
                        final method = paymentMethods[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPaymentIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                              left: 15,
                              right: 15,
                            ),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAEFFA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Radio<int>(
                                  activeColor: colorPrimary,
                                  fillColor: MaterialStateProperty.resolveWith<
                                    Color
                                  >((Set<MaterialState> states) {
                                    if (!states.contains(
                                      MaterialState.selected,
                                    )) {
                                      return colorPrimary; // Inactive border color
                                    }
                                    return colorPrimary; // Active color
                                  }),
                                  value: index,
                                  groupValue: selectedPaymentIndex,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentIndex = value!;
                                    });
                                  },
                                ),
                                Text(
                                  method["title"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.06,
        ),
        child: SubmitButtonWidget(
          text:
              widget.bookingType == "home"
                  ? Strings.sentRequest
                  : Strings.paylabel,
          onTap: () {
            final bookingData =
                widget.bookingData ??
                {
                  'date': "08 Feb 2025",
                  'time': "09:00 AM - 09:30 AM",
                  'patient': "Merlin Joy",
                  'consult_type':
                      widget.bookingType == "home"
                          ? "Request Home Visit"
                          : "Video Consult",
                };
            if (widget.bookingType == "home") {
              final controller = Get.put(BookingsController());
              controller.bookHomeVisit(
                doctorId: widget.doctorData?['id']?.toString() ?? "3",
                memberId: widget.bookingData?['member_id']?.toString(),
                date: widget.bookingData?['date'] ?? "2025-02-08",
                startTime: widget.bookingData?['start_time'] ?? "09:00 AM",
                endTime: widget.bookingData?['end_time'] ?? "09:30 AM",
                consultationFee: fee,
                total: total.toStringAsFixed(0),
                doctorData: widget.doctorData,
                bookingData: bookingData,
              );
            } else {
              Get.to(
                () => DoctorRequestSentSuccess(
                  bookingType: "video",
                  msg: "You've Successfully Booked Doctor Appointments.",
                  doctorData: widget.doctorData,
                  bookingData: bookingData,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
