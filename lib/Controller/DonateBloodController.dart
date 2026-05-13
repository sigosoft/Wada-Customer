import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class DonateBloodController extends GetxController {
  final Dio _dio = ApiConfigs.dio;

  List<String> countryCodes = [];
  List<int> countryIds = [];
  String? selectedCountryCode;
  int? selectedCountryId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? selectedBloodGroup;
  String? selectedGender;

  @override
  void onInit() {
    super.onInit();
    fetchCountryCodes();
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
      print("Error fetching country codes: $e");
    }
  }

  @override
  void onClose() {
    print("DonateBloodController closed");
    super.onClose();
  }

  void submitDonor(Function onSuccess) {
    if (nameController.text.trim().isEmpty) {
      _showSnackBar("Error", "Please enter your name");
      return;
    }
    if (selectedBloodGroup == null) {
      _showSnackBar("Error", "Please select blood group");
      return;
    }
    if (selectedGender == null) {
      _showSnackBar("Error", "Please select gender");
      return;
    }
    if (selectedCountryId == null) {
      _showSnackBar("Error", "Please select country code");
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showSnackBar("Error", "Please enter phone number");
      return;
    }
    if (locationController.text.trim().isEmpty) {
      _showSnackBar("Error", "Please enter location");
      return;
    }

    // Since there's no specific API endpoint provided for this yet,
    // we'll just show the success bottom sheet as requested by UI.
    onSuccess();
  }

  void _showSnackBar(String title, String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(message, style: const TextStyle(fontSize: 12)),
            ],
          ),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
