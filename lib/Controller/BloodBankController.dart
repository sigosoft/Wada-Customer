import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class BloodBankController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> donors = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchDonors();
  }

  Future<void> fetchDonors() async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.donorsList}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        donors = response.data['data']?['donors'] ?? [];
      }
    } catch (e) {
      print("--- API Error (Donors List) ---");
      print("Error fetching donors: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    print("BloodBankController disposed");
    super.onClose();
  }
}
