import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class SettingsController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  var isLoading = false.obs;
  bool tabValue = false;
  String aboutUsContent = "";
  String termsContent = "";
  String privacyPolicyContent = "";
  Map<String, dynamic>? contactUsData;
  List<bool> expanded = [];
  List<Map<String, String>> faqData = [];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchAboutUs() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.aboutUs}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        aboutUsContent = response.data['data']['content'] ?? "";
        print("About Us Content: $aboutUsContent");
      }
    } catch (e) {
      print("--- API Error (About Us) ---");
      print("Error fetching about us: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchTerms() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.terms}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        termsContent = response.data['data']['content'] ?? "";
        print("Terms Content: $termsContent");
      }
    } catch (e) {
      print("--- API Error (Terms) ---");
      print("Error fetching terms: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.privacyPolicy}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        privacyPolicyContent = response.data['data']['content'] ?? "";
        print("Privacy Policy Content: $privacyPolicyContent");
      }
    } catch (e) {
      print("--- API Error (Privacy Policy) ---");
      print("Error fetching privacy policy: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.faqs}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        final List data = response.data['data'] ?? [];
        faqData = data.map((item) {
          return {
            'title': item['question']?.toString() ?? '',
            'subtitle': item['answer']?.toString() ?? '',
          };
        }).toList();

        // Initialize expanded list based on data length
        expanded = List<bool>.filled(faqData.length, false);

        print("FAQs parsed: ${faqData.length} items");
      }
    } catch (e) {
      print("--- API Error (FAQs) ---");
      print("Error fetching FAQs: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchContactUs() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.contactUs}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        contactUsData = response.data['data'];
        print("Contact Us Data: $contactUsData");
      }
    } catch (e) {
      print("--- API Error (Contact Us) ---");
      print("Error fetching contact us: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

}