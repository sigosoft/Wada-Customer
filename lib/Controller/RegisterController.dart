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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for registration fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();
  
  String? selectedGender;
  bool isAgreedToTerms = false;

  @override
  void onInit() {
    super.onInit();
    fetchCountryCodes();
    print("Registercontroller initialized");
  }

  @override
  void onClose() {
    firstNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    referralCodeController.dispose();
    print("Registercontroller disposed");
    super.onClose();
  }

  Future<void> fetchCountryCodes() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getCountryCodes}";

      print("--- API Request (Register) ---");
      print("URL: $url");
      print("Method: GET");

      final response = await _dio.get(url);

      print("--- API Response (Register) ---");
      print("Status Code: ${response.statusCode}");
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
    // Validation
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    if (!isAgreedToTerms) {
      _showError("Please agree to the Terms and Conditions");
      return;
    }

    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.sendRegOtp}";

      FormData formData = FormData.fromMap({
        "first_name": firstNameController.text.trim(),
        "email": emailController.text.trim(),
        "country_code": selectedCountryId?.toString() ?? "2",
        "country_code_id": selectedCountryId?.toString() ?? "2",
        "mobile": phoneController.text.trim(),
        "dob": dobController.text.trim(),
        "gender": selectedGender,
        "referral_code": referralCodeController.text.trim(),
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
        _showError(response.data['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      print("--- API Error (Register OTP) ---");
      print("Error sending register OTP: $e");
      _showError("Something went wrong. Please try again.");
    }
  }

  void _showError(String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
