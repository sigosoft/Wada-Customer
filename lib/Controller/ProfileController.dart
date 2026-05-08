import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Profile/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileController extends GetxController {
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    debugPrint("ProfileController initialized");
  }

  @override
  void onClose() {
    debugPrint("ProfileController disposed");
    super.onClose();
  }

  bool premiumMembership = true;

  void showDeleteAccountDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: logoutTextColor,
                    borderRadius: BorderRadius.circular(10.0),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 2,
                    //     blurRadius: 5,
                    //     offset: Offset(0, 3), // Shadow position
                    //   ),
                    // ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "lib/Assets/Images/deleteIcon.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                TextStyleInterWithoutPadding (
                  text: Strings.deleteAccount,
                  color: profileText2,
                  fontWeight: FontWeight.w700,
                  size: 16.00,
                ),
                SizedBox(height: 5,),
                TextStyleInterWithoutPadding (
                  text: Strings.areYouSureToDeleteAccount,
                  color: profileText2,
                  fontWeight: FontWeight.w400,
                  size: 13.00,
                ),
                SizedBox(height: 5,),
                TextStyleInterWithoutPadding (
                  text: Strings.thisCantBeUnDone,
                  color: logoutTextColor,
                  fontWeight: FontWeight.w400,
                  size: 13.00,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SubmitButton(
                      height: 50.00,
                      width: MediaQuery.of(context).size.width * 0.40,
                      text: Strings.no,
                      color: noButtonColor,
                      textColor: logoutTextColor,
                    ),
                    SubmitButton(
                      height: 50.00,
                      width: MediaQuery.of(context).size.width * 0.40,
                      text: Strings.yes,
                      color: logoutTextColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCustomPopup(BuildContext context, String imagePath, String qrCodeId) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        imagePath,
                        height: MediaQuery.of(context).size.height * 0.18,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextStyleInterForSplash(
                      text: qrCodeId,
                      color: blackTextColor2,
                      fontWeight: FontWeight.w400,
                      size: 12.00,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showLogoutShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SvgPicture.asset(
                "lib/Assets/Images/logout.svg",
                width: 50,
                height: 50,
              ),
              SizedBox(height: 5),
              Text(
                Strings.logout,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.logoutmsg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE7F4FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.no,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorPrimaryDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.yes,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }



  Future<void> logout() async {
    try {
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.logout}";
      
      print("--- API Request (Logout) ---");
      print("URL: $url");
      print("Method: GET");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      print("--- API Response (Logout) ---");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.data}");

      if (response.statusCode == 200 && response.data['status'].toString() == "true") {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
        
        Get.offAll(const LoginScreen());
      } else {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(response.data['message'] ?? "Logout failed")),
          );
        }
      }
    } catch (e) {
      print("--- API Error (Logout) ---");
      print("Error during logout: $e");
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Something went wrong. Please try again.")),
        );
      }
    }
  }
}

