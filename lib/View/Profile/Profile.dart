import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/ProfileController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/CompleteHealthCards.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/HealthcardMedicalRecords.dart';

// import 'package:waada_customerapp/View/FamilyMember/FamilyMemberScreen.dart';
import 'package:waada_customerapp/View/Membership/MemberShipScreen.dart';
import 'package:waada_customerapp/View/Notifications/NotificationsListing.dart';
import 'package:waada_customerapp/View/Profile/DoctorDetailsWidget.dart';
import 'package:waada_customerapp/View/Profile/HealthCardWidget.dart';
import 'package:waada_customerapp/View/Profile/LogoutWidget.dart';
import 'package:waada_customerapp/View/Profile/More.dart';
import 'package:waada_customerapp/View/Profile/ProfileAppBarWidget.dart';
import 'package:waada_customerapp/View/Profile/ProfileRowWidget.dart';
import 'package:waada_customerapp/View/Profile/Referral.dart';
import 'package:waada_customerapp/View/Settings/HelpCenter.dart';
import 'package:waada_customerapp/View/Wallet/WalletListing.dart';
import 'package:waada_customerapp/Widgets/PremiumMembershipCardWidget.dart';

import '../FamilyMember/FamilyMemberScreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: profileBg,
      appBar: ProfileAppBar(
        onTap: () {
          Get.to(More());
        },
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: ProfileController(),
            builder:
                (controller) => Column(
                  children: [
                    SizedBox(height: 10),
                    DoctorDetailsWidget(
                      premiumMembership: controller.premiumMembership,
                      onTapQrCode: () {
                        controller.showCustomPopup(
                          context,
                          "lib/Assets/Images/QrCodeBig.png",
                          "ID : 375467",
                        );
                      },
                    ),
                    if (controller.premiumMembership)
                      PremiumMembershipCardWidget(),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Get.to(CompleteHealthCards());
                      },
                      child: HealthCardWidget(),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            ProfileRowWidget(
                              svgIcon: "lib/Assets/Images/familymembericon.svg",
                              text: Strings.familyMembers,
                              onTap: () {
                                Get.to(FamilyMemberScreen());
                              },
                            ),
                            const Divider(color: borderLine, thickness: 1.0),
                            ProfileRowWidget(
                              svgIcon: "lib/Assets/Images/walletIcon.svg",
                              text: Strings.wallet,
                              onTap: () {
                                Get.to(WalletListing());
                              },
                            ),
                            const Divider(color: borderLine, thickness: 1.0),
                            ProfileRowWidget(
                              svgIcon:
                                  "lib/Assets/Images/notificationsIcon.svg",
                              text: Strings.notifications,
                              onTap: () {
                                Get.to(NotificationsListing());
                              },
                            ),
                            const Divider(color: borderLine, thickness: 1.0),
                            ProfileRowWidget(
                              svgIcon: "lib/Assets/Images/membershipIcon.svg",
                              text: Strings.membership,
                              onTap: () {
                                Get.to(MemberShipScreen());
                              },
                            ),
                            const Divider(color: borderLine, thickness: 1.0),
                            ProfileRowWidget(
                              svgIcon: "lib/Assets/Images/helpIcon.svg",
                              text: Strings.helpCentre,
                              onTap: () {
                                Get.to(HelpCenter());
                              },
                            ),
                            const Divider(color: borderLine, thickness: 1.0),
                            ProfileRowWidget(
                              svgIcon: "lib/Assets/Images/refferalIcon.svg",
                              text: Strings.refferal,
                              onTap: () {
                                Get.to(Referral());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    LogoutWidget(
                      onTap: () {
                        controller.showLogoutShiftBottomSheet(context);
                      },
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
