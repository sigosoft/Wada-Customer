import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class DoctorListingController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> doctors = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.doctorsList}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        doctors = response.data['data']['doctors'] ?? [];
      }
    } catch (e) {
      print("--- API Error (Doctors List) ---");
      print("Error fetching doctors: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    print("DoctorListingController disposed");
    super.onClose();
  }
}