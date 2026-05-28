import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:waada_customerapp/View/Ambulance/Ambulance.dart';
import 'package:waada_customerapp/View/BloodBank/BloodBankListing.dart';
import 'package:waada_customerapp/View/Doctors/DoctorsListingListing.dart';
import 'package:waada_customerapp/View/Laboratory/Laboratory.dart';
import 'package:waada_customerapp/View/MedicalStore/MedicalStore.dart';
import 'package:waada_customerapp/View/NurseBookings/BookNurse.dart';

class HomeController extends GetxController {
  final Dio _dio = ApiConfigs.dio;

  // Home API data
  Map<String, dynamic>? homeData;
  bool isLoading = false;

  String currentAddress = "Fetching location...";
  String currentCity = "Raipur";

  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
    getCurrentLocation();
    fetchHomeData();
    fetchApprovedBookings();
    fetchHours();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentAddress = "Location services disabled";
        update();
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          currentAddress = "Location permission denied";
          update();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        currentAddress = "Location permissions permanently denied";
        update();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        currentCity = place.locality ?? "Raipur";

        // Build address string carefully
        List<String> parts = [];
        if (place.name != null && place.name!.isNotEmpty)
          parts.add(place.name!);
        if (place.subLocality != null && place.subLocality!.isNotEmpty)
          parts.add(place.subLocality!);
        if (place.locality != null && place.locality!.isNotEmpty)
          parts.add(place.locality!);
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty)
          parts.add(place.administrativeArea!);

        currentAddress = parts.join(", ");
        update();
      }
    } catch (e) {
      print("Error getting location: $e");
      currentAddress = "Location not available";
      update();
    }
  }

  Future<void> onRefresh() async {
    await Future.wait([fetchHomeData(), fetchApprovedBookings(), fetchHours()]);
  }

  List<dynamic> shiftHours = [];

  Future<void> fetchHours() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getHours}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        shiftHours = response.data['data']['hours'] ?? [];
        print("Shift Hours Parsed: $shiftHours");
        update();
      } else {
        print("Get Hours API failed or returned false status");
      }
    } catch (e) {
      print("--- API Error (Get Hours) ---");
      print("Error fetching hours: $e");
    }
  }

  List<dynamic> approvedBookings = [];

  Future<void> fetchApprovedBookings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.listBookings}?limit=10&type=0&page=1";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['success'].toString() == "true") {
        List allBookings = response.data['data']['data'] ?? [];
        approvedBookings =
            allBookings
                .where((b) => b['booking_status'].toString() == "1")
                .toList();
        print("Approved Bookings Parsed: ${approvedBookings.length}");
        update();
      } else {
        print("Approved Bookings API failed or returned false success");
        approvedBookings = [];
        update();
      }
    } catch (e) {
      print("--- API Error (Approved Bookings) ---");
      print("Error fetching approved bookings: $e");
    }
  }

  @override
  void onClose() {
    print("HomeController disposed");
    super.onClose();
  }

  int currentIndex = 0;
  int currentIndex2 = 0;

  // Carousel image URLs - populated from API (main_sliders)
  List<String> imageUrls = [];

  // Main services - populated from API (mainServiceNames)
  List<Map<String, String>> homeRowWidgetItems = [];

  List<Widget> screenWidgets = [
    DoctorsListingListing(),
    BookNurse(),
    BloodBankListing(),
  ];

  // Other services - populated from API (otherServiceNames)
  List<Map<String, dynamic>> otherServicesList = [];

  // Bottom carousel image URLs - populated from API (bottom_sliders)
  List<String> imageUrls2 = [];

  // Helper: build a widget for a given service name from API
  Widget _widgetFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('ambulance')) return Ambulance();
    if (n.contains('nurse') || n.contains('nursing')) return BookNurse();
    if (n.contains('lab') ||
        n.contains('pathology') ||
        n.contains('diagnostic'))
      return Laboratory();
    if (n.contains('store') ||
        n.contains('medical store') ||
        n.contains('pharmacy'))
      return MedicalStore();
    if (n.contains('blood')) return BloodBankListing();
    if (n.contains('doctor')) return DoctorsListingListing();
    return const Scaffold(body: Center(child: Text("Service coming soon")));
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

  // Helper: build full image URL from relative path
  String _fullImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return "${ApiConfigs.IMAGE_URL}$path";
  }

  Future<void> fetchHomeData() async {
    try {
      if (homeData == null) {
        isLoading = true;
        update();
      }

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.home}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        homeData = response.data['data'];

        print("--- Home Data Parsed Successfully ---");
        print("Home Data Keys: ${homeData?.keys.toList()}");

        // --- Parse main_sliders (first carousel) ---
        final mainSliders = homeData?['main_sliders'];
        if (mainSliders != null && mainSliders is List) {
          imageUrls =
              mainSliders
                  .map((s) => _fullImageUrl(s['image']?.toString()))
                  .where((u) => u.isNotEmpty)
                  .toList();
          print("main_sliders parsed: $imageUrls");
        }

        // --- Parse bottom_sliders (second carousel) ---
        final bottomSliders = homeData?['bottom_sliders'];
        if (bottomSliders != null && bottomSliders is List) {
          imageUrls2 =
              bottomSliders
                  .map((s) => _fullImageUrl(s['image']?.toString()))
                  .where((u) => u.isNotEmpty)
                  .toList();
          print("bottom_sliders parsed: $imageUrls2");
        }

        // --- Parse mainServiceNames (horizontal scroll) ---
        final mainServices = homeData?['mainServiceNames'];
        if (mainServices != null &&
            mainServices is List &&
            mainServices.isNotEmpty) {
          homeRowWidgetItems =
              mainServices.map((s) {
                final imageUrl = _fullImageUrl(s['image']?.toString());
                return {
                  'icon': imageUrl,
                  'name': s['name']?.toString() ?? '',
                  'description': s['description']?.toString() ?? '',
                };
              }).toList();

          // Dynamically build screenWidgets matching mainServiceNames
          screenWidgets =
              mainServices.map((s) {
                return _widgetFor(s['name']?.toString() ?? '');
              }).toList();

          print(
            "mainServiceNames parsed: ${homeRowWidgetItems.map((e) => e['name']).toList()}",
          );
        }

        // --- Parse otherServiceNames (grid) ---
        final otherServices = homeData?['otherServiceNames'];
        if (otherServices != null &&
            otherServices is List &&
            otherServices.isNotEmpty) {
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
          print(
            "otherServiceNames parsed: ${otherServicesList.map((e) => e['name']).toList()}",
          );
        }
      } else {
        print("--- Home API returned non-success status ---");
        print("Message: ${response.data['message']}");
      }
    } catch (e) {
      print("--- API Error (Home) ---");
      print("Error fetching home data: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
