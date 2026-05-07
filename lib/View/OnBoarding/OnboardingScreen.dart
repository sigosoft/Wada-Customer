import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/View/Login/Login.dart';
import 'package:waada_customerapp/View/Register/Register.dart';

import '../../Resource/Strings.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "lib/Assets/Images/onboardingimage1.svg",
      "title": "Lorem ipsum",
      "description": Strings.dummy,
    },
    {
      "image": "lib/Assets/Images/onboardingimage2.svg",
      "title": "Lorem ipsum",
      "description": Strings.dummy,
    },
    {
      "image": "lib/Assets/Images/onboardingimage3.svg",
      "title": "Lorem ipsum",
      "description": Strings.dummy,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colorPrimary, colorPrimaryDark1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        onboardingData[index]["image"]!,
                        width: 300,
                        height: 330,
                      ),
                      // SizedBox(height: 20),
                      Text(
                        onboardingData[index]["title"]!,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        onboardingData[index]["description"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: white,
                        ),
                      ),
                      SizedBox(height: 15),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: onboardingData.length,
                        effect: ExpandingDotsEffect(
                          dotColor: white,
                          activeDotColor: colorPrimary,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 40,
              right: 10,
              child:
                  _currentPage == onboardingData.length - 1
                      ? Container()
                      : IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Get.offAll(LoginScreen());
                        },
                      ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  if (_currentPage == 1 || _currentPage == 2)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          "lib/Assets/Images/cancelbutton.svg",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == onboardingData.length - 1) {
                          Get.offAll(LoginScreen());
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Text(
                        Strings.next,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
