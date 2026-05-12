import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/Ambulance/Ambulance.dart';
import 'package:waada_customerapp/View/BloodBank/BloodBankListing.dart';
import 'package:waada_customerapp/View/Doctors/DoctorsListingListing.dart';
import 'package:waada_customerapp/View/Laboratory/Laboratory.dart';
import 'package:waada_customerapp/View/MedicalStore/MedicalStore.dart';
import 'package:waada_customerapp/View/NurseBookings/BookNurse.dart';

class HomeController extends GetxController {
  final Dio _dio = Dio();

  // Home API data
  Map<String, dynamic>? homeData;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
    fetchHomeData();
    fetchSpecializations();
    fetchOtherServices();
    fetchHours();
  }

  Future<void> onRefresh() async {
    await Future.wait([
      fetchHomeData(),
      fetchSpecializations(),
      fetchOtherServices(),
      fetchHours(),
    ]);
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

      print("--- API Request (Get Hours) ---");
      print("URL: $url");
      print("Headers: $headers");
      print("Token: $token");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Get Hours) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

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

  Future<void> fetchOtherServices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.otherServiceNames}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Other Services) ---");
      print("URL: $url");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Other Services) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        final List otherServices = response.data['data'] ?? [];
        if (otherServices.isNotEmpty) {
          final localIcons = [
            "lib/Assets/Images/OtherServicesIcon1.svg",
            "lib/Assets/Images/OtherServicesIcon2.svg",
            "lib/Assets/Images/OtherServicesIcon3.svg",
            "lib/Assets/Images/OtherServicesIcon4.svg",
            "lib/Assets/Images/OtherServicesIcon5.svg",
            "lib/Assets/Images/OtherServicesIcon6.svg",
          ];
          otherServicesList =
              otherServices.asMap().entries.map((entry) {
                final i = entry.key;
                final s = entry.value;
                final name = s['name']?.toString() ?? '';
                final imageUrl = _fullImageUrl(s['image']?.toString());
                final icon =
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : (i < localIcons.length
                            ? localIcons[i]
                            : localIcons.last);
                return <String, dynamic>{
                  'icon': icon,
                  'name': name,
                  'route': _routeFor(name),
                };
              }).toList();
          update();
        }
      }
    } catch (e) {
      print("--- API Error (Other Services) ---");
      print("Error fetching other services: $e");
    }
  }

  List<dynamic> specializationsList = [];

  Future<void> fetchSpecializations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.specializations}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Specializations) ---");
      print("URL: $url");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Specializations) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        // The API might return a list directly or wrapped in 'data'
        if (response.data is List) {
          specializationsList = response.data;
        } else if (response.data['status'].toString() == "true") {
          specializationsList = response.data['data'] ?? [];
        }
        update();
      }
    } catch (e) {
      print("--- API Error (Specializations) ---");
      print("Error fetching specializations: $e");
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
  List<String> imageUrls = [
    'lib/Assets/Images/carousalSliderDummy.png',
    'lib/Assets/Images/carousalSliderDummy.png',
    'lib/Assets/Images/carousalSliderDummy.png',
  ];

  // Main services - populated from API (mainServiceNames)
  List<Map<String, String>> homeRowWidgetItems = [
    {
      'icon': "lib/Assets/Images/HomeScreenRowIcon1.svg",
      'name': 'Doctor',
      'description': 'Browse by specialty, availability, and location.',
    },
    {
      'icon': 'lib/Assets/Images/HomeScreenRowIcon2.svg',
      'name': 'Nurses',
      'description': 'Home care services & appointment booking.',
    },
    {
      'icon': 'lib/Assets/Images/HomeScreenRowIcon3.svg',
      'name': 'Blood Bank',
      'description': 'Home care services & appointment booking.',
    },
  ];

  List<Widget> screenWidgets = [
    DoctorsListingListing(),
    BookNurse(),
    BloodBankListing(),
  ];

  // Other services - populated from API (otherServiceNames)
  List<Map<String, dynamic>> otherServicesList = [
    {
      'icon': "lib/Assets/Images/OtherServicesIcon1.svg",
      'name': 'Ambulance',
      'route': () => Get.to(() => Ambulance()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon2.svg",
      'name': 'Pathology Lab',
      'route': () => Get.to(() => Laboratory()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon3.svg",
      'name': 'Diagnostic Center',
      'route': () => Get.to(() => Ambulance()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon4.svg",
      'name': 'Medical Equipment',
      'route': () => Get.to(() => Ambulance()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon5.svg",
      'name': 'Medical Store',
      'route': () => Get.to(() => MedicalStore()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon6.svg",
      'name': 'Laboratories',
      'route': () => Get.to(() => Laboratory()),
    },
  ];

  // Bottom carousel image URLs - populated from API (bottom_sliders)
  List<String> imageUrls2 = [
    'lib/Assets/Images/homeSliderDummyImage.png',
    'lib/Assets/Images/homeSliderDummyImage.png',
    'lib/Assets/Images/homeSliderDummyImage.png',
  ];

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
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.home}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Home) ---");
      print("URL: $url");
      print("Method: GET");
      print("Headers: $headers");
      print("Token: $token");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Home) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        homeData = response.data['data'];

        print("--- Home Data Parsed Successfully ---");
        print("Home Data Keys: ${homeData?.keys.toList()}");

        // --- Parse main_sliders (first carousel) ---
        final mainSliders = homeData?['main_sliders'];
        if (mainSliders != null &&
            mainSliders is List &&
            mainSliders.isNotEmpty) {
          final parsedUrls =
              mainSliders
                  .map((s) => _fullImageUrl(s['image']?.toString()))
                  .where((u) => u.isNotEmpty)
                  .toList();
          if (parsedUrls.isNotEmpty) {
            imageUrls = List<String>.from(parsedUrls);
            print("main_sliders parsed: $imageUrls");
          }
        }

        // --- Parse bottom_sliders (second carousel) ---
        final bottomSliders = homeData?['bottom_sliders'];
        if (bottomSliders != null &&
            bottomSliders is List &&
            bottomSliders.isNotEmpty) {
          final parsedUrls =
              bottomSliders
                  .map((s) => _fullImageUrl(s['image']?.toString()))
                  .where((u) => u.isNotEmpty)
                  .toList();
          if (parsedUrls.isNotEmpty) {
            imageUrls2 = List<String>.from(parsedUrls);
            print("bottom_sliders parsed: $imageUrls2");
          }
        }

        // --- Parse mainServiceNames (horizontal scroll) ---
        final mainServices = homeData?['mainServiceNames'];
        if (mainServices != null &&
            mainServices is List &&
            mainServices.isNotEmpty) {
          final localIcons = [
            "lib/Assets/Images/HomeScreenRowIcon1.svg",
            "lib/Assets/Images/HomeScreenRowIcon2.svg",
            "lib/Assets/Images/HomeScreenRowIcon3.svg",
          ];
          homeRowWidgetItems =
              mainServices.asMap().entries.map((entry) {
                final i = entry.key;
                final s = entry.value;
                final imageUrl = _fullImageUrl(s['image']?.toString());
                // Use network image if available, else fall back to local SVG icon
                final icon =
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : (i < localIcons.length
                            ? localIcons[i]
                            : localIcons.last);
                return {
                  'icon': icon,
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
          final localIcons = [
            "lib/Assets/Images/OtherServicesIcon1.svg",
            "lib/Assets/Images/OtherServicesIcon2.svg",
            "lib/Assets/Images/OtherServicesIcon3.svg",
            "lib/Assets/Images/OtherServicesIcon4.svg",
            "lib/Assets/Images/OtherServicesIcon5.svg",
            "lib/Assets/Images/OtherServicesIcon6.svg",
          ];
          otherServicesList =
              otherServices.asMap().entries.map((entry) {
                final i = entry.key;
                final s = entry.value;
                final name = s['name']?.toString() ?? '';
                final imageUrl = _fullImageUrl(s['image']?.toString());
                final icon =
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : (i < localIcons.length
                            ? localIcons[i]
                            : localIcons.last);
                return <String, dynamic>{
                  'icon': icon,
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
