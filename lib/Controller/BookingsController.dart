import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/View/SuccessPages/DoctorBookingsSuccess/DoctorRequestSentSuccess.dart';
import '../Configs/ApiConfigs.dart';
import '../Resource/Colors.dart';
import '../Resource/Strings.dart';
import '../View/Login/SubmitButtonWidget.dart';
import '../View/SuccessPages/DoctorBookingsSuccess/DoctorPaymentSuccess.dart';
import '../View/SuccessPages/NurseBookingsSuccess/CancelBookingSuccess.dart';
import '../Widgets/widgets.dart';

class BookingsController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> nurseBookings = [];
  bool isNurseLoading = false;
  bool isLoadMore = false;
  int currentPage = 1;
  bool hasMore = true;
  Map<String, dynamic>? selectedBookingDetails;
  bool isDetailsLoading = false;

  @override
  void onInit() {
    super.onInit();
    print("BookingsController initialized");
    fetchNurseBookings();
  }

  Future<void> updateNursePaymentStatus(int bookingId) async {
    print(
      "--- [BookingsController] updateNursePaymentStatus triggered for ID: $bookingId ---",
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.updateNursePaymentStatus}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final Map<String, dynamic> data = {'booking_id': bookingId.toString()};
      print("--- [BookingsController] Request: POST $url ---");
      print("--- [BookingsController] Headers: $headers ---");
      print("--- [BookingsController] Body: $data ---");

      final FormData formData = FormData.fromMap(data);

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print(
        "--- [BookingsController] Response Status: ${response.statusCode} ---",
      );
      print("--- [BookingsController] Response Data: ${response.data} ---");

      if (response.statusCode == 200 &&
          (response.data['success'] == true ||
              response.data['success'].toString() == "true")) {
        print("--- [BookingsController] Payment status update SUCCESS ---");
      } else {
        print(
          "--- [BookingsController] Payment status update FAILED (check data) ---",
        );
      }
    } catch (e) {
      print("--- [BookingsController] API EXCEPTION: $e ---");
    }
  }

  Future<void> fetchBookingDetails(int bookingId) async {
    try {
      isDetailsLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.bookingDetails}?booking_id=$bookingId";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 && response.data['data'] != null) {
        selectedBookingDetails = response.data['data'];
      }
    } catch (e) {
      print("--- API Error (Booking Details) ---");
      print("Error fetching booking details: $e");
    } finally {
      isDetailsLoading = false;
      update();
    }
  }

  Future<void> fetchNurseBookings() async {
    try {
      currentPage = 1;
      hasMore = true;
      isNurseLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.listBookings}?limit=10&type=0&page=$currentPage";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['success'].toString() == "true") {
        nurseBookings = response.data['data']['data'] ?? [];
        if (nurseBookings.length < 10) {
          hasMore = false;
        }
      } else {
        nurseBookings = [];
      }
    } catch (e) {
      nurseBookings = [];
    } finally {
      isNurseLoading = false;
      update();
    }
  }

  Future<void> loadMoreNurseBookings() async {
    if (isLoadMore || !hasMore) return;

    try {
      isLoadMore = true;
      update();

      currentPage++;
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.listBookings}?limit=10&type=0&page=$currentPage";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['success'].toString() == "true") {
        List newBookings = response.data['data']['data'] ?? [];
        if (newBookings.isEmpty) {
          hasMore = false;
        } else {
          nurseBookings.addAll(newBookings);
          if (newBookings.length < 10) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      print("--- API Error (Load More Bookings) ---");
      currentPage--;
    } finally {
      isLoadMore = false;
      update();
    }
  }

  List<dynamic> get requestBookings =>
      nurseBookings
          .where((b) => b['booking_status'].toString() == "0")
          .toList();
  List<dynamic> get upcomingBookings =>
      nurseBookings
          .where((b) => b['booking_status'].toString() == "1")
          .toList();
  List<dynamic> get completedBookings =>
      nurseBookings
          .where((b) => b['booking_status'].toString() == "2")
          .toList();
  List<dynamic> get cancelledBookings =>
      nurseBookings
          .where((b) => b['booking_status'].toString() == "3")
          .toList();

  List<dynamic> getBookingsForIndex(int index) {
    if (index == 0) return requestBookings;
    if (index == 1) return upcomingBookings;
    if (index == 2) return completedBookings;
    if (index == 3) return cancelledBookings;
    return [];
  }

  Future<void> bookHomeVisit({
    required String doctorId,
    required String? memberId,
    required String date,
    required String startTime,
    required String endTime,
    required String consultationFee,
    required String total,
    required Map<String, dynamic>? doctorData,
    required Map<String, dynamic>? bookingData,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.bookHomeVisit}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      String formatTo24h(String time) {
        try {
          final parts = time.split(' ');
          if (parts.length < 2) return time;
          final timeParts = parts[0].split(':');
          int hour = int.parse(timeParts[0]);
          final minute = timeParts[1];
          final ampm = parts[1].toUpperCase();

          if (ampm == 'PM' && hour < 12) hour += 12;
          if (ampm == 'AM' && hour == 12) hour = 0;

          return "${hour.toString().padLeft(2, '0')}:$minute";
        } catch (e) {
          return time;
        }
      }

      final Map<String, dynamic> data = {
        'doctor_id': doctorId,
        if (memberId != null) 'member_id': memberId,
        'date': date,
        'start_time': formatTo24h(startTime),
        'end_time': formatTo24h(endTime),
        'consultation_fee': consultationFee,
        'total': total,
        'service_fee': "",
        'commision': "",
      };

      print("--- [BookingsController] bookHomeVisit Request ---");
      print("URL: $url");
      print("Body: $data");

      final FormData formData = FormData.fromMap(data);

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print("--- [BookingsController] bookHomeVisit Response ---");
      print("Status: ${response.statusCode}");
      print("Data: ${response.data}");

      if (response.statusCode == 200 &&
          (response.data['status'] == true ||
              response.data['status'].toString() == "true")) {
        Get.to(
          () => DoctorRequestSentSuccess(
            bookingType: "home",
            msg:
                response.data['message'] ??
                "Home visit request sent successfully.",
            doctorData: doctorData,
            bookingData: bookingData,
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ?? "Failed to book home visit",
            ),
          ),
        );
      }
    } catch (e) {
      print("--- [BookingsController] bookHomeVisit EXCEPTION: $e ---");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text("An error occurred during booking")),
      );
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.cancelBooking}?booking_id=$bookingId";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          (response.data['success'] == true ||
              response.data['success'].toString() == "true")) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ?? "Booking cancelled successfully",
            ),
          ),
        );
        fetchNurseBookings();
        final details = selectedBookingDetails?['booking_details'];
        Get.back(); // Close the bottom sheet
        Get.off(
          () => CancelBookingSuccess(
            data: {
              'name': details?['name'],
              'location': details?['location'],
              'qualification': details?['qualification'],
              'experience': details?['experience'],
              'image': details?['image'],
              'checkin_date': details?['checkin_date'],
              'checkin_time': details?['checkin_time'],
              'languages':
                  (details?['languages'] as List?)
                      ?.map((l) => (l is Map) ? l['language'] : l)
                      .toList(),
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'] ?? "Failed to cancel booking",
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("An error occurred while cancelling booking"),
        ),
      );
    }
  }

  @override
  void onClose() {
    print("BookingsController disposed");
    super.onClose();
  }

  Color boxColor1 = colorPrimary;
  Color textColor1 = Colors.white;
  Color boxColor2 = colorPrimaryWith25Opacity;
  Color textColor2 = colorPrimary;
  bool switchValue = true;
  double sizedBoxHeight = 150.00;

  List<String> attatchmentList = [
    'lib/Assets/Images/attatchmentDummy.png',
    'lib/Assets/Images/attatchmentDummy.png',
    'lib/Assets/Images/attatchmentDummy.png',
  ];

  void swapColors() {
    final tempBoxColor = boxColor1;
    final tempTextColor = textColor1;
    boxColor1 = boxColor2;
    textColor1 = textColor2;
    boxColor2 = tempBoxColor;
    textColor2 = tempTextColor;
    switchValue = !switchValue;
    update();
  }

  List<String> itemList = [
    "All",
    "George Jacob",
    "Merlin Thomas ",
    "Thomas James",
    "John Doe",
  ];

  void showPaymentBottomSheet(
    BuildContext context,
    String selectedMethod,
    Function(String) onChanged,
    VoidCallback onPay, {
    Map<String, dynamic>? doctorData,
    Map<String, dynamic>? bookingData,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        String method = selectedMethod;
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "lib/Assets/Images/paymentIcon.svg",
                          ),
                        ),
                        SizedBox(width: 10),
                        Spacer(),
                        IconButton(
                          icon: SvgPicture.asset(
                            "lib/Assets/Images/CloseIcon.svg",
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        TextStyleInterWithoutPadding(
                          text: Strings.payment,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          size: 14.00,
                        ),
                        SizedBox(height: 30),
                        RadioListTile<String>(
                          value: 'Online Transaction',
                          groupValue: method,
                          onChanged: (value) {
                            setState(() => method = value!);
                            onChanged(value!);
                          },
                          title: TextStyleInterWithoutPadding(
                            text: Strings.onlineTransaction,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            size: 14.00,
                          ),
                          fillColor: MaterialStateProperty.all(colorPrimary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: Colors.grey[100],
                        ),
                        SizedBox(height: 10),
                        RadioListTile<String>(
                          value: 'Wada Pay',
                          groupValue: method,
                          fillColor: MaterialStateProperty.all(colorPrimary),
                          onChanged: (value) {
                            setState(() => method = value!);
                            onChanged(value!);
                          },
                          title: TextStyleInterWithoutPadding(
                            text: Strings.wadaPay,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            size: 14.00,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: greyBg,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SubmitButtonWidget(
                      text: Strings.payText,
                      onTap: () {
                        Get.off(
                          () => DoctorPaymentSuccess(
                            doctorData: doctorData,
                            bookingData: bookingData,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showVideoConsultBottomSheet(
    BuildContext context,
    VoidCallback onYesTap,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xff318AD1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.videocam,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextStyleInterWithoutPadding(
                  text: Strings.videoConsult,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  size: 14.00,
                ),
                const SizedBox(height: 10),
                TextStyleInterWithoutPadding(
                  text: Strings.areYouSureWantToJoin,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  size: 12.00,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor: colorPrimaryWith15Opacity,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: TextStyleInterWithoutPadding(
                          text: Strings.no,
                          color: colorPrimary,
                          fontWeight: FontWeight.w600,
                          size: 14.00,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onYesTap();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: TextStyleInterWithoutPadding(
                          text: Strings.yes,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          size: 14.00,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
