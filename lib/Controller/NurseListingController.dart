import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class NurseListingController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> nurses = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      fetchNurses(args);
    } else {
      // Default fetch if no arguments (e.g. from home directly)
      fetchNurses({});
    }
  }

  Future<void> fetchNurses(Map<String, dynamic> searchParams) async {
    try {
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.nursesList}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(
        url,
        queryParameters: searchParams,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        nurses = response.data['data']['nurses'] ?? [];
      } else {
        nurses = [];
      }
    } catch (e) {
      print("--- API Error (Nurses List) ---");
      print("Error fetching nurses: $e");
      nurses = [];
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    print("NurseListingController disposed");
    super.onClose();
  }
}
