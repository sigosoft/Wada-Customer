import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class WalletController extends GetxController {
  final Dio _dio = Dio();
  var isLoading = false.obs;

  double availableCoins = 0;
  double pointRate = 1.0;
  List<dynamic> walletLogs = [];

  @override
  void onInit() {
    super.onInit();
    fetchWalletDetails();
  }

  Future<void> fetchWalletDetails() async {
    try {
      isLoading.value = true;
      update();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.wallet}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print("--- API Request (Wallet) ---");
      print("URL: $url");

      final response = await _dio.get(url, options: Options(headers: headers));

      print("--- API Response (Wallet) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        var data = response.data['data'];
        availableCoins = double.tryParse(data['available_coins'].toString()) ?? 0;
        pointRate = double.tryParse(data['settings']['point_rate'].toString()) ?? 1.0;
        walletLogs = data['wallet_logs'] ?? [];
      }
    } catch (e) {
      print("--- API Error (Wallet) ---");
      print("Error fetching wallet: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
