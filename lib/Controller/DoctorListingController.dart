import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/DoctorBookings/RequestHomeVisit.dart';
import 'package:waada_customerapp/View/DoctorBookings/VideoConsult.dart';

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

      final response = await _dio.get(url, options: Options(headers: headers));

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

  Future<void> fetchDoctorDetails(int doctorId, int consultType) async {
    if (doctorId == 0) {
      print("Invalid doctorId: 0");
      return;
    }
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url =
          "${ApiConfigs.BASE_URL}${ApiEndPoints.doctorDetails}?doctor_id=$doctorId&consultation_type=$consultType";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          (response.data['status'] == true ||
              response.data['status'].toString() == "true")) {
        var doctorData = response.data['data']['doctor'];
        if (consultType == 1) {
          Get.to(() => const RequestHomeVisit(), arguments: doctorData);
        } else {
          Get.to(() => const VideoConsult(), arguments: doctorData);
        }
      }
    } catch (e) {
      print("--- API Error (Doctor Details) ---");
      print("Error fetching doctor details: $e");
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
