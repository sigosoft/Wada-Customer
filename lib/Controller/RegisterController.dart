import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';
import 'package:waada_customerapp/View/Login/Login.dart';
import 'package:waada_customerapp/View/Home/Home.dart';

class Registercontroller extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<String> countryCodes = [];
  List<int> countryIds = [];
  String? selectedCountryCode;
  int? selectedCountryId;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(
    debugLabel: 'RegisterFormKey',
  );

  // Controllers for registration fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

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

      final response = await _dio.get(url);

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
    if (firstNameController.text.trim().isEmpty) {
      _showError("Please enter first name");
      return;
    }
    if (emailController.text.trim().isEmpty) {
      _showError("Please enter email");
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      _showError("Please enter a valid email");
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError("Please enter phone number");
      return;
    }
    if (dobController.text.trim().isEmpty) {
      _showError("Please select date of birth");
      return;
    }
    if (selectedGender == null) {
      _showError("Please select gender");
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

      final response = await _dio.post(url, data: formData);

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

  Future<void> register() async {
    if (otpController.text.length < 6) {
      _showError("Please enter a valid 6-digit OTP");
      return;
    }

    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.register}";

      final Map<String, dynamic> body = {
        "otp": otpController.text.trim(),
        "name": firstNameController.text.trim(),
        "gender": selectedGender,
        "country_code_id": selectedCountryId?.toString() ?? "2",
        "mobile": phoneController.text.trim(),
        "dob": dobController.text.trim(),
        "email": emailController.text.trim(),
      };

      if (referralCodeController.text.trim().isNotEmpty) {
        body["referral_code"] = referralCodeController.text.trim();
      }

      FormData formData = FormData.fromMap(body);

      print("--- Register Request ---");
      print("URL: $url");
      print("Fields: ${formData.fields}");

      final response = await _dio.post(url, data: formData);

      print("--- Register Response ---");
      print(response.data);

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text("Registration Successful!")),
          );
        }
        if (Get.isRegistered<LoginController>()) {
          Get.delete<LoginController>(force: true);
        }
        Get.delete<Registercontroller>(force: true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => LoginScreen());
        });
      } else {
        _handleApiError(response.data);
      }
    } on DioException catch (e) {
      print("--- API Error (Register DioException) ---");
      if (e.response != null && e.response?.data != null) {
        print("Error Data: ${e.response?.data}");
        _handleApiError(e.response?.data);
      } else {
        _showError("Something went wrong. Please try again.");
      }
    } catch (e) {
      print("--- API Error (Register General Exception) ---");
      print("Error: $e");
      _showError("Something went wrong. Please try again.");
    }
  }

  void _handleApiError(dynamic data) {
    if (data is Map && data['message'] != null) {
      var message = data['message'];
      if (message is Map) {
        // Handle validation errors (e.g., {referral_code: [invalid]})
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
      _showError("Registration failed");
    }
  }

  void _showError(String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
