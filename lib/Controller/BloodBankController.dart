import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class BloodBankController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> donors = [];
  bool isLoading = false;
  bool isLoadMore = false;
  int currentPage = 1;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchDonors();
  }

  Future<void> fetchDonors() async {
    try {
      currentPage = 1;
      hasMore = true;
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.donorsList}?page=$currentPage";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        donors = response.data['data']?['donors'] ?? [];
        if (donors.length < 10) {
          hasMore = false;
        }
      }
    } catch (e) {
      print("--- API Error (Donors List) ---");
      print("Error fetching donors: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMoreDonors() async {
    if (isLoadMore || !hasMore) return;

    try {
      isLoadMore = true;
      update();

      currentPage++;
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.donorsList}?page=$currentPage";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        List newDonors = response.data['data']?['donors'] ?? [];
        if (newDonors.isEmpty) {
          hasMore = false;
        } else {
          donors.addAll(newDonors);
          if (newDonors.length < 10) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      print("--- API Error (Load More Donors) ---");
      currentPage--;
    } finally {
      isLoadMore = false;
      update();
    }
  }

  @override
  void onClose() {
    print("BloodBankController disposed");
    super.onClose();
  }
}
