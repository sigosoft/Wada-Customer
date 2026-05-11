import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import 'package:waada_customerapp/Controller/BottomNavController.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool showCloseIcon;
  final bool showBackButton;
  final dynamic elevation;

  const CustomAppBar({
    super.key,
    required this.label,
    this.showCloseIcon = true,
    this.showBackButton = true,
    this.elevation,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      leading:
          showBackButton
              ? InkWell(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else if (Get.isRegistered<BottomNavController>()) {
                    Get.find<BottomNavController>().backToHome();
                  } else {
                    Get.back();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "lib/Assets/Images/BackButton.svg",
                    fit: BoxFit.scaleDown,
                    color: Colors.black,
                  ),
                ),
              )
              : Container(),
      title: Padding(
        padding: showBackButton ? EdgeInsets.zero : EdgeInsets.only(left: 20.0),
        child: TextStyleInterForSplash(
          text: label,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
      ),
      titleSpacing: -20.0, // Adjust this value to reduce the gap
      toolbarHeight: 50,
      actions:
          showCloseIcon
              ? [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      "lib/Assets/Images/CloseIcon.svg",
                      fit: BoxFit.scaleDown,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]
              : null,
      elevation: elevation ?? 3,
      scrolledUnderElevation: 3.0,
    );
  }
}
