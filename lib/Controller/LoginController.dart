import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<String> countryCodes = [];
  List<int> countryIds = [];
  String? selectedCountryCode;
  int? selectedCountryId;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchCountryCodes();
    print("LoginController initialized");
  }

  Future<void> fetchCountryCodes() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getCountryCodes}";

      final response = await _dio.get(url);

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        List codes = response.data['data']['country_codes'];
        countryCodes = codes.map((e) => e['country_code'].toString()).toList();
        countryIds = codes.map((e) => int.parse(e['id'].toString())).toList();
        update();
      }
    } catch (e) {
    }
  }

  Future<void> sendLoginOtp() async {
    if (selectedCountryId == null) {
      _showError("Please select country code");
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError("Please enter phone number");
      return;
    }
    if (phoneController.text.trim().length < 10) {
      _showError("Please enter a valid 10-digit phone number");
      return;
    }

    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.sendLoginOtp}";

      String code = selectedCountryCode!.replaceAll('+', '');

      FormData formData = FormData.fromMap({
        "country_code": selectedCountryId.toString(),
        "country_code_id": selectedCountryId.toString(),
        "mobile": phoneController.text,
        "otp": "123456",
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        Get.to(const OtpScreen2());
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
      print("--- API Error (Login OTP) ---");
      print("Error sending login OTP: $e");
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong. Please try again."),
          ),
        );
      }
    }
  }

  Future<void> login() async {
    if (otpController.text.length < 6) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
        );
      }
      return;
    }

    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.login}";

      FormData formData = FormData.fromMap({
        "country_code": selectedCountryId?.toString() ?? "2",
        "country_code_id": selectedCountryId?.toString() ?? "2",
        "mobile": phoneController.text,
        "otp": otpController.text,
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        String token = response.data['data']['details']['token'];
        print("--- Auth Token ---");
        print(token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        Get.offAll(() => Home());
      } else {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(response.data['message'] ?? "Login failed")),
          );
        }
      }
    } catch (e) {
      print("--- API Error (Login) ---");
      print("Error during login: $e");
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong. Please try again."),
          ),
        );
      }
    }
  }

  void _showError(String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    print("LoginController disposed");
    super.onClose();
  }
}
