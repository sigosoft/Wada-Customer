import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/BottomNavController.dart';
import 'package:waada_customerapp/View/Bookings/Bookings.dart';
import 'package:waada_customerapp/View/Home/HomeItem.dart';
import 'package:waada_customerapp/View/Profile/Profile.dart';
import 'package:waada_customerapp/View/ServiceListing/ServiceListing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> _pages = [
    const HomeItem(),
    const ServiceListing(),
    const Bookings(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          controller.backToHome();
          return false;
        }
        return true;
      },
      child: Obx(
        () => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            selectedLabelStyle: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            onTap: controller.changeIndex,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.selectedIndex.value == 0
                      ? "lib/Assets/Images/BottomNavIcon1.svg"
                      : "lib/Assets/Images/bottomNavIcon1Unselected.svg",
                  fit: BoxFit.scaleDown,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.selectedIndex.value == 1
                      ? "lib/Assets/Images/botomNavIcon2Selected.svg"
                      : "lib/Assets/Images/BottomNavIcon2.svg",
                  fit: BoxFit.scaleDown,
                ),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.selectedIndex.value == 2
                      ? "lib/Assets/Images/BottomNavIcon3.svg"
                      : "lib/Assets/Images/BottomNavIcon3Unselected.svg",
                  fit: BoxFit.scaleDown,
                ),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.selectedIndex.value == 3
                      ? "lib/Assets/Images/bottomnavIcon4Selected.svg"
                      : "lib/Assets/Images/BottomNavIcon4.svg",
                  fit: BoxFit.scaleDown,
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}