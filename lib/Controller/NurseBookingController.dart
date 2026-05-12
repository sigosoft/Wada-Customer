import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class NurseBookingController extends GetxController {
  final Dio _dio = Dio();
  List<dynamic> categories = [];
  List<int> selectedCategoryIds = [];
  bool isLoading = false;
  bool isDetailsLoading = false;
  Map<String, dynamic>? nurseData;
  String fromDate = "";
  String toDate = "";
  String hourId = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
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

      print("--- API Request (Healthcare Categories) ---");
      print("URL: $url");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Healthcare Categories) ---");
      print("Status Code: ${response.statusCode}");
      // print("Response Body: ${response.data}");

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
    String hourIdStr,
  ) async {
    try {
      isDetailsLoading = true;
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

      print("--- API Request (Nurse Details) ---");
      print("Token: $token");
      print("Headers: $headers");
      print("URL: $url");
      print("Parameters: $queryParameters");

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      print("--- API Response (Nurse Details) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

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
}
