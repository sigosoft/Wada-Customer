import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/RequestSentSuccess.dart';
import '../Configs/ApiConfigs.dart';

class NurseBookingController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> categories = [];
  List<int> selectedCategoryIds = [];
  List<dynamic> members = [];
  int? selectedMemberId;
  bool isLoading = false;
  bool isDetailsLoading = false;
  Map<String, dynamic>? nurseData;
  String fromDate = "";
  String toDate = "";
  String hourId = "";
  String location = "";
  String latitude = "";
  String longitude = "";
  String amount = "0";
  final TextEditingController checkinTimeController = TextEditingController(
    text: "10:00 AM",
  );
  final TextEditingController checkoutTimeController = TextEditingController(
    text: "11:00 AM",
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchMembers();
    fetchHours();
  }

  List<dynamic> shiftHours = [];

  Future<void> fetchHours() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getHours}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        shiftHours = response.data['data']['hours'] ?? [];
        print("Shift Hours Parsed: $shiftHours");
        update();
      } else {
        print("Get Hours API (NurseBooking) failed or returned false status");
      }
    } catch (e) {
      print("--- API Error (Get Hours - NurseBooking) ---");
      print("Error fetching hours: $e");
    }
  }

  Future<void> fetchMembers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.members}?limit=10";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        members = response.data['data']['members']['data'] ?? [];
        if (members.isNotEmpty) {
          selectedMemberId = members[0]['id'];
        }
        update();
      }
    } catch (e) {
      print("Error fetching members: $e");
    }
  }

  Map<String, dynamic>? get selectedMember {
    if (selectedMemberId == null) return null;
    return members.firstWhereOrNull((m) => m['id'] == selectedMemberId);
  }

  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.healthcareCategories}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        categories = response.data['data'] ?? [];
      } else {
        categories = [];
      }
    } catch (e) {
      print("--- API Error (Healthcare Categories) ---");
      print("Error fetching categories: $e");
      categories = [];
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> fetchNurseDetails(
    int nurseId,
    String fromDateStr,
    String toDateStr,
    String hourIdStr, {
    String locationStr = "",
    String latitudeStr = "",
    String longitudeStr = "",
    String amountStr = "0",
  }) async {
    try {
      isDetailsLoading = true;
      location = locationStr;
      latitude = latitudeStr;
      longitude = longitudeStr;
      amount = amountStr;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.nurseDetails}";

      final queryParameters = {
        'nurse_id': nurseId,
        'from_date': fromDateStr,
        'to_date': toDateStr,
        'hour_id': hourIdStr,
      };

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        nurseData = response.data['data']['nurse'];
        fromDate = response.data['data']['from_date'] ?? "";
        toDate = response.data['data']['to_date'] ?? "";
        hourId = response.data['data']['hour_id'] ?? "";
      } else {
        nurseData = null;
      }
    } catch (e) {
      print("--- API Error (Nurse Details) ---");
      print("Error fetching nurse details: $e");
      nurseData = null;
    } finally {
      isDetailsLoading = false;
      update();
    }
  }

  Future<void> bookNurse() async {
    // Safety validation
    if (selectedMemberId == null) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Please select a patient")),
        );
      }
      return;
    }
    if (selectedCategoryIds.isEmpty) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Please select at least one service requirement"),
          ),
        );
      }
      return;
    }
    if (notesController.text.trim().isEmpty) {
      if (Get.context != null) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(const SnackBar(content: Text("Please enter notes")));
      }
      return;
    }

    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.bookNurse}";

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
        'nurse_id': nurseData?['id'],
        'member_id': selectedMemberId,
        'from_date': fromDate,
        'to_date': toDate,
        'hour_id': hourId,
        'checkin_time': formatTo24h(checkinTimeController.text),
        'checkout_time': formatTo24h(checkoutTimeController.text),
        'amount': amount,
        'location': location,
        'latitude': double.tryParse(latitude.toString()),
        'longitude': double.tryParse(longitude.toString()),
        'note': notesController.text,
      };

      // Add healthcare_category_id[0], [1], etc.
      for (int i = 0; i < selectedCategoryIds.length; i++) {
        data['healthcare_category_id[$i]'] = selectedCategoryIds[i];
      }

      final FormData formData = FormData.fromMap(data);

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        Get.to(
          () => RequestSentSuccess(
            data: {
              'name': nurseData?['name'],
              'location': nurseData?['location'],
              'qualification': nurseData?['qualification'],
              'experience': nurseData?['experience'],
              'image': nurseData?['image'],
              'checkin_date': fromDate,
              'checkin_time': checkinTimeController.text,
              'languages':
                  (nurseData?['languages'] as List?)
                      ?.map((l) => l['language'] ?? l)
                      .toList(),
            },
          ),
        );
      } else {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(response.data['message'] ?? "Booking failed"),
            ),
          );
        }
      }
    } catch (e) {
      print("--- API Error (Book Nurse) ---");
      print("Error booking nurse: $e");
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("An error occurred during booking")),
        );
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void toggleCategory(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
    update();
  }

  bool isCategorySelected(int id) {
    return selectedCategoryIds.contains(id);
  }

  @override
  void onClose() {
    notesController.dispose();
    checkinTimeController.dispose();
    checkoutTimeController.dispose();
    super.onClose();
  }
}
