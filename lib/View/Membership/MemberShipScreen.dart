import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Coupons/CouponsListing.dart';
import 'package:waada_customerapp/View/Membership/CheckBoxWithTextWidget.dart';
import 'package:waada_customerapp/View/Membership/NormalAppBar.dart';
import 'package:waada_customerapp/View/Membership/SubmitButtonWhiteColor.dart';
import 'package:waada_customerapp/View/Membership/membershipWidget.dart';
import 'package:waada_customerapp/View/Settings/TermsAndConditions.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Resource/Colors.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({super.key});

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  bool isChecked = false;
  final int price = 1499;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: premiumMembershipColor,
      appBar: NormalAppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showComingSoonDialog(context);
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("lib/Assets/Images/CrownImage.svg"),
                  SizedBox(height: 20),
                  TextStyleInterForSplash(
                    text: Strings.waadaPremiumMembership,
                    fontWeight: FontWeight.w700,
                    color: premiumMembershipText,
                    size: MediaQuery.of(context).size.width * 0.055,
                  ),
                  SizedBox(height: 20),
                  MemberShipCard(
                    icon: "lib/Assets/Images/MembershipHealthCardIcon.svg",
                    membershipDescription:
                        Strings.membershipHealthCardDescription,
                    membershipName: Strings.healthCard,
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.to(CouponsListing());
                    },
                    child: MemberShipCard(
                      icon: "lib/Assets/Images/MembershipWowCouponsIcon.svg",
                      membershipDescription: Strings.wowCouponsDescription,
                      membershipName: Strings.wowCoupon,
                    ),
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon: "lib/Assets/Images/MembershipFastServiceIcon.svg",
                    membershipDescription: Strings.fastServiceDescription,
                    membershipName: Strings.fastService,
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon: "lib/Assets/Images/MembershipGetUpdatesIcon.svg",
                    membershipDescription: Strings.getUpdateDescription,
                    membershipName: Strings.getUpdates,
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon:
                        "lib/Assets/Images/MembershipAccidentalInsuranceIcon.svg",
                    membershipDescription: Strings.accidentalInsuranceDescription,
                    membershipName: Strings.accidentalInsurance,
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon:
                        "lib/Assets/Images/MembershipHMedicalHospitalFaciltyIcon.svg",
                    membershipDescription: Strings.medicalHospFacilityDescription,
                    membershipName: Strings.medicalHospFacility,
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon: "lib/Assets/Images/MembershipPremiumBadgeIcon.svg",
                    membershipDescription: Strings.premiumBadgeDescription,
                    membershipName: Strings.premiumBadge,
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon: "lib/Assets/Images/MembershipMedicalOffersIcon.svg",
                    membershipDescription: Strings.medicalOffersDescription,
                    membershipName: Strings.medicalOffers,
                  ),
                  SizedBox(height: 10),
                  CheckBoxWithTextWidget(
                    isChecked: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  SubmitButtonWhite(amount: price,),
                  SizedBox(height: 20),
                  TextStyleInterForSplash(
                    text: "Cupidatat irure theas Laborum magna nulla",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.03,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(TermsAndConditions());
                        },
                        child: TextStyleInterForSplash(
                          text: Strings.termsAndConditions,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(TermsAndConditions());
                        },
                        child: TextStyleInterForSplash(
                          text: Strings.privacyPolicy,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



