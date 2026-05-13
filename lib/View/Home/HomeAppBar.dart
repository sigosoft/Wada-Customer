import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:waada_customerapp/Controller/HomeController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/View/Notifications/NotificationsListing.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      elevation: 3,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 3.0,
      leading: SvgPicture.asset(
        "lib/Assets/Images/locationIcon.svg",
        fit: BoxFit.scaleDown,
      ),
      title: GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleInterWithoutPadding(
                textAlign: TextAlign.center,
                text: controller.currentCity,
                color: blackTextColor2,
                fontWeight: FontWeight.w600,
                size: 16.00,
              ),
              TextStyleInterWithoutPadding(
                textAlign: TextAlign.center,
                text: controller.currentAddress,
                color: blackTextColor2,
                fontWeight: FontWeight.w400,
                size: 12.00,
              ),
            ],
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              Get.to(() => NotificationsListing());
            },
            child: SvgPicture.asset(
              "lib/Assets/Images/bellIcon.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
