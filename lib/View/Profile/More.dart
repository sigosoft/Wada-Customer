import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/ProfileController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Membership/MemberShipScreen.dart';
import 'package:waada_customerapp/View/Notifications/NotificationsListing.dart';
import 'package:waada_customerapp/View/Profile/DoctorDetailsWidget.dart';
import 'package:waada_customerapp/View/Profile/HealthCardWidget.dart';
import 'package:waada_customerapp/View/Profile/LogoutWidget.dart';
import 'package:waada_customerapp/View/Profile/ProfileAppBarWidget.dart';
import 'package:waada_customerapp/View/Profile/ProfileRowWidget.dart';
import 'package:waada_customerapp/View/Profile/Referral.dart';
import 'package:waada_customerapp/View/Settings/AboutUs.dart';
import 'package:waada_customerapp/View/Settings/Faq.dart';
import 'package:waada_customerapp/View/Settings/HelpCenter.dart';
import 'package:waada_customerapp/View/Settings/PrivacyPolicy.dart';
import 'package:waada_customerapp/View/Settings/TermsAndConditions.dart';
import 'package:waada_customerapp/View/Wallet/WalletListing.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';

import '../FamilyMember/FamilyMemberScreen.dart';
import 'BecomeServiceProvider.dart';
import 'DeleteAccountWidget.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: '',showCloseIcon: false,),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GetBuilder(
          init: ProfileController(),
          builder:
              (controller) => Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: borderLine,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ProfileRowWidget(
                        svgIcon: "lib/Assets/Images/serviceprovider.svg",
                        text: Strings.becomeserviceProvider,
                        onTap: () {
                          Get.to(BecomeServiceProvider());
                        },
                      ),
                       Divider(color: Colors.grey.shade300, thickness: 1.0),
                      ProfileRowWidget(
                        svgIcon: "lib/Assets/Images/about.svg",
                        text: Strings.aboutUs,
                        onTap: () {
                          Get.to(AboutUs());
                        },
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1.0),
                      ProfileRowWidget(
                        svgIcon: "lib/Assets/Images/faq.svg",
                        text: Strings.faqs,
                        onTap: () {
                          Get.to(Faq());
                        },
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1.0),
                      ProfileRowWidget(
                        svgIcon: "lib/Assets/Images/serviceprovider.svg",
                        text: Strings.termsAndConditions,
                        onTap: () {
                          Get.to(TermsAndConditions());
                        },
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1.0),
                      ProfileRowWidget(
                        svgIcon: "lib/Assets/Images/privacy.svg",
                        text: Strings.privacyPolicy,
                        onTap: () {
                          Get.to(PrivacyPolicy());
                        },
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              DeleteAccountWidget(
                onTap: () {
                  controller.showDeleteAccountDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
