import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/BloodBank/BloodBankListing.dart';
import 'package:waada_customerapp/View/Doctors/DoctorsListingListing.dart';
import 'package:waada_customerapp/View/NurseBookings/BookNurse.dart';

import '../View/Ambulance/Ambulance.dart';
import '../View/Laboratory/Laboratory.dart';
import '../View/MedicalStore/MedicalStore.dart';

class ServiceListingController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<Map<String, dynamic>> otherServicesList = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    print("ServiceListingController initialized");
    fetchOtherServices();
  }

  Future<void> fetchOtherServices() async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.otherServiceNames}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        final List otherServices = response.data['data'] ?? [];
        if (otherServices.isNotEmpty) {
          otherServicesList =
              otherServices.map((s) {
                final name = s['name']?.toString() ?? '';
                final imageUrl = _fullImageUrl(s['image']?.toString());
                return <String, dynamic>{
                  'icon': imageUrl,
                  'name': name,
                  'route': _routeFor(name),
                };
              }).toList();
        }
      }
    } catch (e) {
      print("--- API Error (Other Services Listing) ---");
      print("Error fetching other services: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  // Helper: build full image URL from relative path
  String _fullImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return "${ApiConfigs.IMAGE_URL}$path";
  }

  // Helper: build a route for a given service name from API
  Function _routeFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('ambulance')) return () => Get.to(() => Ambulance());
    if (n.contains('nurse') || n.contains('nursing'))
      return () => Get.to(() => BookNurse());
    if (n.contains('lab') ||
        n.contains('pathology') ||
        n.contains('diagnostic'))
      return () => Get.to(() => Laboratory());
    if (n.contains('store') ||
        n.contains('medical store') ||
        n.contains('pharmacy'))
      return () => Get.to(() => MedicalStore());
    if (n.contains('blood')) return () => Get.to(() => BloodBankListing());
    if (n.contains('doctor'))
      return () => Get.to(() => DoctorsListingListing());
    return () {};
  }
}
