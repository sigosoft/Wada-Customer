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
  bool isLoadMore = false;
  int currentPage = 1;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      currentPage = 1;
      hasMore = true;
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.doctorsList}?page=$currentPage";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        doctors = response.data['data']['doctors'] ?? [];
        if (doctors.length < 10) { // Assuming 10 is the limit
          hasMore = false;
        }
      }
    } catch (e) {
      print("--- API Error (Doctors List) ---");
      print("Error fetching doctors: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMoreDoctors() async {
    if (isLoadMore || !hasMore) return;

    try {
      isLoadMore = true;
      update();

      currentPage++;
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.doctorsList}?page=$currentPage";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        List newDoctors = response.data['data']['doctors'] ?? [];
        if (newDoctors.isEmpty) {
          hasMore = false;
        } else {
          doctors.addAll(newDoctors);
          if (newDoctors.length < 10) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      print("--- API Error (Load More Doctors) ---");
      currentPage--;
    } finally {
      isLoadMore = false;
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
