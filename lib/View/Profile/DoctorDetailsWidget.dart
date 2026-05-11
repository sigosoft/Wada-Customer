import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Profile/CustomCliprect.dart';
import 'package:waada_customerapp/View/Profile/EditProfile.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Resource/Colors.dart'
    show blackTextColor2, colorPrimary, profileText2;

class DoctorDetailsWidget extends StatelessWidget {
  final dynamic onTapQrCode;
  final dynamic premiumMembership;
  final Map<String, dynamic>? patientData;

  const DoctorDetailsWidget({
    super.key,
    this.onTapQrCode,
    this.premiumMembership = false,
    this.patientData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 130.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              premiumMembership
                  ? BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )
                  : BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomClipRRect(
                      borderRadius: 60,
                      imagePath:
                          patientData?['image'] != null
                              ? "${ApiConfigs.IMAGE_URL}${patientData!['image']}"
                              : "lib/Assets/Images/doctorProfileImage.png",
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextStyleInterForSplash(
                                  text: patientData?['name'] ?? "User Name",
                                  color: blackTextColor2,
                                  fontWeight: FontWeight.w700,
                                  size: 16.00,
                                ),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset(
                                'lib/Assets/Images/verifiedIcon.svg',
                                fit: BoxFit.scaleDown,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextStyleInterForSplash(
                            text:
                                "${patientData?['country_code'] ?? ""} ${patientData?['mobile'] ?? ""}",
                            color: profileText2,
                            fontWeight: FontWeight.w400,
                            size: 13.00,
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Get.to(() => EditProfile());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextStyleInterForSplash(
                                  text: Strings.editProfile,
                                  color: colorPrimary,
                                  fontWeight: FontWeight.w600,
                                  size: 13.00,
                                ),
                                const SizedBox(width: 4),
                                SvgPicture.asset(
                                  'lib/Assets/Images/ArrowForward.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onTapQrCode,
                    child: ClipRRect(
                      child: SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: Image.asset("lib/Assets/Images/qrImage.png"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Id : ${patientData?['id'] ?? "375467"}",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
