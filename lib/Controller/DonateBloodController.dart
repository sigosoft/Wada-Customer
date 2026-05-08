import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class DonateBloodController extends GetxController {
  final Dio _dio = Dio();
  
  List<String> countryCodes = [];
  List<int> countryIds = [];
  String? selectedCountryCode;
  int? selectedCountryId;
  
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
}
