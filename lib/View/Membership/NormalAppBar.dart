import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NormalAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: premiumMembershipColor,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: SvgPicture.asset(
          "lib/Assets/Images/BackButton.svg",
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}