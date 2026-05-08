import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';

class Registercontroller extends GetxController {
  final Dio _dio = Dio();
  List<String> countryCodes = [];
  List<int> countryIds = [];
  String? selectedCountryCode;
  int? selectedCountryId;
  final TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCountryCodes();
    print("Registercontroller initialized");
  }

  @override
  void onClose() {
    phoneController.dispose();
    print("Registercontroller disposed");
    super.onClose();
  }

  Future<void> fetchCountryCodes() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getCountryCodes}";

      print("--- API Request (Register) ---");
      print("URL: $url");
      print("Method: GET");
      print("Headers: ${_dio.options.headers}");

      final response = await _dio.get(url);

      print("--- API Response (Register) ---");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        List codes = response.data['data']['country_codes'];
        countryCodes = codes.map((e) => e['country_code'].toString()).toList();
        countryIds = codes.map((e) => int.parse(e['id'].toString())).toList();
        update();
      }
    } catch (e) {
      print("--- API Error (Register) ---");
      print("Error fetching country codes: $e");
    }
  }

  Future<void> sendRegOtp() async {
    if (selectedCountryCode == null || phoneController.text.isEmpty) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Please select country code and enter phone number"),
          ),
        );
      }
      return;
    }

    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.sendRegOtp}";

      FormData formData = FormData.fromMap({
        "country_code": selectedCountryId?.toString() ?? "2",
        "country_code_id": selectedCountryId?.toString() ?? "2",
        "mobile": phoneController.text,
      });

      print("--- API Request (Register OTP) ---");
      print("URL: $url");
      print("Method: POST");
      print("Request Body: ${formData.fields}");

      final response = await _dio.post(url, data: formData);

      print("--- API Response (Register OTP) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        Get.to(const OtpScreen2());
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(
                response.data['message'] ?? "OTP Sent Successfully",
              ),
            ),
          );
        }
      } else {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(response.data['message'] ?? "Failed to send OTP"),
            ),
          );
        }
      }
    } catch (e) {
      print("--- API Error (Register OTP) ---");
      print("Error sending register OTP: $e");
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong. Please try again."),
          ),
        );
      }
    }
  }
}
