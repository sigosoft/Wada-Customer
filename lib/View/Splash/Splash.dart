import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/View/Login/Login.dart';
import 'package:waada_customerapp/View/OnBoarding/OnboardingScreen.dart';
import 'package:waada_customerapp/View/Splash/ButtonWidget.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      print("--- SPLASH SCREEN TOKEN CHECK ---");
      print("Token found: $token");

      if (token != null && token.isNotEmpty) {
        // Small delay to let the splash UI render before navigating
        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => Home());
      } else {
        print("No valid token found. Staying on Splash.");
      }
    } catch (e) {
      print("Error reading SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [blueGradient1, blueGradient2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "lib/Assets/Images/WaadaSymbol.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 30),
              SvgPicture.asset(
                "lib/Assets/Images/splashImage.svg",
                fit: BoxFit.scaleDown,
              ),
              SizedBox(height: 50),
              TextStyleInterForSplash(
                text: "Lorem ipsum",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                size: 20.00,
              ),
              SizedBox(height: 20),
              TextStyleInterForSplash(
                text:
                    "Quis autem vel eum iure reprehenderit qui in eareda voluptate velit.",
                color: Colors.white,
                fontWeight: FontWeight.w400,
                size: 16.00,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ButtonWidget(
                onTap: () {
                  Get.to(OnboardingScreen());
                },
                text: "Get Started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
