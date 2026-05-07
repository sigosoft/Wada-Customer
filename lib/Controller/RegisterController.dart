import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class Registercontroller extends GetxController {
  final Dio _dio = Dio();
  List<String> countryCodes = [];

  @override
  void onInit() {
    super.onInit();
    print("Registercontroller initialized");
  }

  Future<void> fetchCountryCodes() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.getCountryCodes}";
      
      print("--- API Request (Register) ---");
      print("URL: $url");
      print("Method: GET");
      print("Headers: ${_dio.options.headers}");

      final response = await _dio.get(url);

      print("--- API Response (Register) ---");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == "true") {
        List codes = response.data['data']['country_codes'];
        countryCodes = codes.map((e) => e['country_code'].toString()).toList();
        update();
      }
    } catch (e) {
      print("--- API Error (Register) ---");
      print("Error fetching country codes: $e");
    }
  }

  @override
  void onClose() {
    print("Registercontroller disposed");
    super.onClose();
  }
}
