import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/View/Coupons/CouponsListing.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../Resource/Strings.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15),
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEAEFFA), // Background color
        borderRadius: BorderRadius.circular(10), // Rounded edges
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10), // Adjust spacing
                    child: SvgPicture.asset(
                      'lib/Assets/Images/offer.svg', // Path to the SVG file
                      height: 25,
                      width: 25,
                    ),
                  ),
                  TextStyleInterForSplash(
                    text: "30% Off",
                    fontWeight: FontWeight.w700,
                    color: Colors.black, // Black text color
                    size: 14.0,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 35,
                width: 90,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0x4D318AD1), // 30% opacity background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded edges
                    ),
                    elevation: 0,
                    padding: EdgeInsets.zero
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // Ensures text scales to fit
                    child: TextStyleInterForSplash(
                      text: Strings.apply,
                      fontWeight: FontWeight.w600,
                      color: colorPrimaryDark, // Primary color
                      size: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextStyleInterForSplash(
            text: Strings.offerdescription,
            fontWeight: FontWeight.w500,
            color: Colors.grey, // Grey text color
            size: 12.0,
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () {
              Get.to(CouponsListing ());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextStyleInterForSplash(
                  text: Strings.viewAllCoupons,
                  fontWeight: FontWeight.w600,
                  color: colorPrimaryDark, // Primary color
                  size: 13.0,
                ),
                SvgPicture.asset(
                  'lib/Assets/Images/arrowblue.svg', // Path to the SVG file
                  height: 14,
                  width: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}