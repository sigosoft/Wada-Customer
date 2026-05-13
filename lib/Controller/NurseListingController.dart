import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class NurseListingController extends GetxController {
  final Dio _dio = ApiConfigs.dio;
  List<dynamic> nurses = [];
  bool isLoading = false;
  bool isLoadMore = false;
  int currentPage = 1;
  bool hasMore = true;
  Map<String, dynamic> lastSearchParams = {};

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      fetchNurses(args);
    } else {
      fetchNurses({});
    }
  }

  Future<void> fetchNurses(Map<String, dynamic> searchParams) async {
    try {
      lastSearchParams = searchParams;
      currentPage = 1;
      hasMore = true;
      isLoading = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.nursesList}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final queryParams = Map<String, dynamic>.from(searchParams);
      queryParams['page'] = currentPage;

      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        nurses = response.data['data']['nurses'] ?? [];
        if (nurses.length < 10) {
          hasMore = false;
        }
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

  Future<void> loadMoreNurses() async {
    if (isLoadMore || !hasMore) return;

    try {
      isLoadMore = true;
      update();

      currentPage++;
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.nursesList}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final queryParams = Map<String, dynamic>.from(lastSearchParams);
      queryParams['page'] = currentPage;

      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        List newNurses = response.data['data']['nurses'] ?? [];
        if (newNurses.isEmpty) {
          hasMore = false;
        } else {
          nurses.addAll(newNurses);
          if (newNurses.length < 10) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      print("--- API Error (Load More Nurses) ---");
      currentPage--;
    } finally {
      isLoadMore = false;
      update();
    }
  }

  @override
  void onClose() {
    print("NurseListingController disposed");
    super.onClose();
  }
}
