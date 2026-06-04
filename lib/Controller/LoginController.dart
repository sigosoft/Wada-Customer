import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Utils/HelperFunctions.dart';
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

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'LoginFormKey',
  );

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
      } else {
        _handleApiError(response.data, "Failed to fetch country codes");
      }
    } on DioException catch (e) {
      print("--- API Error (Login Country Codes DioException) ---");
      if (e.response != null && e.response?.data != null) {
        print("Error Data: ${e.response?.data}");
        _handleApiError(e.response?.data, "Failed to fetch country codes");
      } else {
        _showError(
          "Failed to fetch country codes. Please check your connection.",
        );
      }
    } catch (e) {
      print("--- API Error (Login Country Codes General Exception) ---");
      print("Error fetching country codes: $e");
      _showError("Something went wrong.");
    }
  }

  Future<void> sendLoginOtp() async {
    print("sendLoginOtp called, phoneController text: ${phoneController.text}");
    if (selectedCountryId == null) {
      _showError("Please select country code");
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError("Please enter phone number");
      return;
    }
    final expectedLength = getPhoneNumberLength(selectedCountryCode);
    if (phoneController.text.trim().length < expectedLength) {
      _showError("Please enter a valid $expectedLength-digit phone number");
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
        _handleApiError(response.data, "Failed to send OTP");
      }
    } on DioException catch (e) {
      print("--- API Error (Login OTP DioException) ---");
      if (e.response != null && e.response?.data != null) {
        print("Error Data: ${e.response?.data}");
        _handleApiError(e.response?.data, "Failed to send OTP");
      } else {
        _showError("Failed to send OTP. Please check your connection.");
      }
    } catch (e) {
      print("--- API Error (Login OTP General Exception) ---");
      print("Error sending login OTP: $e");
      _showError("Something went wrong. Please try again.");
    }
  }

  Future<void> login() async {
    print("login called, phoneController text: ${phoneController.text}");
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
        _handleApiError(response.data, "Login failed");
      }
    } on DioException catch (e) {
      print("--- API Error (Login DioException) ---");
      if (e.response != null && e.response?.data != null) {
        print("Error Data: ${e.response?.data}");
        _handleApiError(e.response?.data, "Login failed");
      } else {
        _showError("Login failed. Please check your connection.");
      }
    } catch (e) {
      print("--- API Error (Login General Exception) ---");
      print("Error during login: $e");
      _showError("Something went wrong. Please try again.");
    }
  }

  void clear() {
    phoneController.clear();
    otpController.clear();
    selectedCountryCode = null;
    selectedCountryId = null;
  }

  void _handleApiError(dynamic data, String fallbackMessage) {
    if (data is Map && data['message'] != null) {
      var message = data['message'];
      if (message is Map) {
        String errorMessage = "";
        message.forEach((key, value) {
          if (value is List) {
            errorMessage += "${value.join(', ')}\n";
          } else {
            errorMessage += "$value\n";
          }
        });
        _showError(errorMessage.trim());
      } else {
        _showError(message.toString());
      }
    } else {
      _showError(fallbackMessage);
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
    print("LoginController disposed");
    super.onClose();
  }
}
