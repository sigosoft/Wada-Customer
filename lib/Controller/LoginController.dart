import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';

class LoginController extends GetxController {
  final Dio _dio = Dio();
  List<String> countryCodes = [];
  String? selectedCountryCode;
  final TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print("LoginController initialized");
  }

  Future<void> fetchCountryCodes() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getCountryCodes}";
      
      print("--- API Request ---");
      print("URL: $url");
      print("Method: GET");
      print("Headers: ${_dio.options.headers}");

      final response = await _dio.get(url);

      print("--- API Response ---");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == "true") {
        List codes = response.data['data']['country_codes'];
        countryCodes = codes.map((e) => e['country_code'].toString()).toList();
        update();
      }
    } catch (e) {
      print("--- API Error ---");
      print("Error fetching country codes: $e");
    }
  }

  Future<void> sendLoginOtp() async {
    if (selectedCountryCode == null || phoneController.text.isEmpty) {
      Get.snackbar("Error", "Please select country code and enter phone number");
      return;
    }

    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.sendLoginOtp}";
      
      String code = selectedCountryCode!.replaceAll('+', '');
      
      Map<String, dynamic> body = {
        "country_code": code,
        "mobile": phoneController.text,
      };

      print("--- API Request (Login OTP) ---");
      print("URL: $url");
      print("Method: POST");
      print("Headers: ${_dio.options.headers}");
      print("Request Body: $body");

      final response = await _dio.post(url, data: body);

      print("--- API Response (Login OTP) ---");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == "true") {
        Get.to(const OtpScreen2());
      } else {
        Get.snackbar("Error", response.data['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      print("--- API Error (Login OTP) ---");
      print("Error sending login OTP: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    print("LoginController disposed");
    super.onClose();
  }
}
