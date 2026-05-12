import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class FamilyMemberController extends GetxController {
  final Dio _dio = Dio();
  var isLoading = false.obs;
  List<dynamic> membersList = [];

  @override
  void onInit() {
    super.onInit();
    fetchCountryCodes();
    fetchMembers();
  }

  // Form Fields for Add Member
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final dobController = TextEditingController();
  String? gender; // "1" for Male, "2" for Female
  String? relationId;
  String? countryCodeId = "1"; // Default to 1
  bool isEmergencyContact = false;
  bool isEditMode = false;
  int? editingMemberId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> countryCodes = [];
  List<int> countryIds = [];
  String? selectedCountryCode;

  void setEditData(Map<String, dynamic> member) {
    isEditMode = true;
    editingMemberId = member['id'];
    nameController.text = member['name'] ?? "";
    addressController.text = member['address'] ?? "";
    mobileController.text = member['mobile'] ?? "";
    dobController.text = member['dob'] ?? "";
    gender = member['gender']?.toString();
    relationId = member['relation_id']?.toString();
    countryCodeId = member['country_code_id']?.toString();
    selectedCountryCode = member['country_code'] ?? "";
    isEmergencyContact = member['emergency_contact']?.toString() == "1";
    update();
  }

  Future<void> fetchCountryCodes() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getCountryCodes}";

      print("--- API Request (FM Country Codes) ---");
      print("URL: $url");

      final response = await _dio.get(url);

      print("--- API Response (FM Country Codes) ---");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        List codes = response.data['data']['country_codes'];
        countryCodes = codes.map((e) => e['country_code'].toString()).toList();
        countryIds = codes.map((e) => int.parse(e['id'].toString())).toList();

        if (selectedCountryCode == null && countryCodes.isNotEmpty) {
          selectedCountryCode = countryCodes[0];
          countryCodeId = countryIds[0].toString();
        }

        print("FM Country codes fetched: ${countryCodes.length} items");
        update();
      }
    } catch (e) {
      print("--- API Error (FM Country Codes) ---");
      print("Error fetching country codes: $e");
    }
  }

  void clearForm() {
    nameController.clear();
    addressController.clear();
    mobileController.clear();
    emergencyContactController.clear();
    dobController.clear();
    gender = null;
    relationId = null;
    isEmergencyContact = false;
    update();
  }

  Future<void> addMember() async {
    // Validation logic
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (gender == null) {
      _showSnackBar("Error", "Please select gender");
      return;
    }
    if (relationId == null) {
      _showSnackBar("Error", "Please select relationship");
      return;
    }

    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.addMember}";

      final formData = FormData.fromMap({
        "name": nameController.text,
        "dob": dobController.text,
        "gender": gender,
        "address": addressController.text,
        "emergency_contact": isEmergencyContact ? "1" : "0",
        "relation_id": relationId,
        "country_code_id": countryCodeId,
        "country_code": selectedCountryCode, // Added this just in case
        "mobile": mobileController.text,
      });

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Add Member) ---");
      print("URL: $url");
      print("Headers: $headers");
      print("Data: ${formData.fields}");

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print("--- API Response (Add Member) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        Get.back();
        fetchMembers(); // Refresh the list
        _showSnackBar("Success", response.data['message'] ?? "Member added");
        clearForm();
      } else {
        _showSnackBar(
          "Error",
          response.data['message'] ?? "Failed to add member",
        );
      }
    } on DioException catch (e) {
      print("--- API Error (Add Member) ---");
      print("Status Code: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}");

      String errorMessage = "Something went wrong";
      if (e.response?.data != null && e.response?.data['message'] != null) {
        var msg = e.response?.data['message'];
        if (msg is Map) {
          errorMessage = msg.values
              .map((e) => (e is List) ? e.join(", ") : e.toString())
              .join("\n");
        } else {
          errorMessage = msg.toString();
        }
      }

      _showSnackBar("Error", errorMessage);
    } catch (e) {
      print("--- API Error (Add Member) ---");
      print("Error adding member: $e");
      _showSnackBar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> updateMember() async {
    // Validation logic
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (gender == null) {
      _showSnackBar("Error", "Please select gender");
      return;
    }
    if (relationId == null) {
      _showSnackBar("Error", "Please select relationship");
      return;
    }

    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.updateMember}";

      final formData = FormData.fromMap({
        "name": nameController.text,
        "dob": dobController.text,
        "gender": gender,
        "address": addressController.text,
        "emergency_contact": isEmergencyContact ? "1" : "0",
        "relation_id": relationId,
        "country_code_id": countryCodeId,
        "country_code": selectedCountryCode,
        "mobile": mobileController.text,
        "member_id": editingMemberId,
      });

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Update Member) ---");
      print("URL: $url");
      print("Data: ${formData.fields}");

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print("--- API Response (Update Member) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        Get.back();
        fetchMembers(); // Refresh the list
        _showSnackBar("Success", response.data['message'] ?? "Member updated");
        clearForm();
      } else {
        _showSnackBar(
          "Error",
          response.data['message'] ?? "Failed to update member",
        );
      }
    } on DioException catch (e) {
      print("--- API Error (Update Member) ---");
      print("Status Code: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}");

      String errorMessage = "Something went wrong";
      if (e.response?.data != null && e.response?.data['message'] != null) {
        var msg = e.response?.data['message'];
        if (msg is Map) {
          errorMessage = msg.values
              .map((e) => (e is List) ? e.join(", ") : e.toString())
              .join("\n");
        } else {
          errorMessage = msg.toString();
        }
      }

      _showSnackBar("Error", errorMessage);
    } catch (e) {
      print("--- API Error (Update Member) ---");
      print("Error updating member: $e");
      _showSnackBar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> deleteMember(int memberId) async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.removeMember}?member_id=$memberId";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Delete Member) ---");
      print("URL: $url");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Delete Member) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        fetchMembers(); // Refresh the list
        _showSnackBar("Success", response.data['message'] ?? "Member removed");
      } else {
        _showSnackBar(
          "Error",
          response.data['message'] ?? "Failed to remove member",
        );
      }
    } catch (e) {
      print("--- API Error (Delete Member) ---");
      print("Error deleting member: $e");
      _showSnackBar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchMembers() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.members}?limit=10";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Members) ---");
      print("URL: $url");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Members) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        membersList = response.data['data']['members']['data'] ?? [];
        print("Members fetched: ${membersList.length} items");
      }
    } catch (e) {
      print("--- API Error (Members) ---");
      print("Error fetching members: $e");
    } finally {
      isLoading.value = false;
      update();
    }
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
