import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import '../../Services/RazorpayService.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../Controller/ProfileController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Coupons/CouponsListing.dart';
import 'package:waada_customerapp/View/Membership/CheckBoxWithTextWidget.dart';
import 'package:waada_customerapp/View/Membership/NormalAppBar.dart';
import 'package:waada_customerapp/View/Membership/SubmitButtonWhiteColor.dart';
import 'package:waada_customerapp/View/Membership/membershipWidget.dart';
import 'package:waada_customerapp/View/Settings/TermsAndConditions.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Configs/ApiConfigs.dart';

import '../../Resource/Colors.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({super.key});

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  bool isChecked = false;
  dynamic price = 1499;
  bool isLoading = false;
  bool isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    fetchMembershipDetails();
  }

  Future<void> handleMembershipPayment() async {
    String email = '';
    String contact = '';
    try {
      ProfileController profileController;
      if (Get.isRegistered<ProfileController>()) {
        profileController = Get.find<ProfileController>();
      } else {
        profileController = Get.put(ProfileController());
      }

      if (profileController.patientData == null) {
        await profileController.fetchProfile();
      }

      email = profileController.patientData?['email']?.toString() ?? '';
      contact = profileController.patientData?['mobile']?.toString() ?? '';
    } catch (e) {
      print("Error getting profile: $e");
    }

    double finalAmount = 1499.0;
    if (price != null) {
      finalAmount = double.tryParse(price.toString()) ?? 1499.0;
    }

    await RazorpayService().startMembershipPayment(
      amount: finalAmount,
      description: "Waada Premium Membership",
      contact: contact,
      email: email,
      key: "rzp_test_T8uZQ7cP2kcNGN",
      autoSubscription: isChecked,
      onSuccess: (successResponse) async {
        print(
          "--- Membership Payment Success: ${successResponse.paymentId} ---",
        );

        // Show loading dialog while verification is in progress
        Get.dialog(
          const Center(child: CircularProgressIndicator(color: Colors.blue)),
          barrierDismissible: false,
        );

        bool verified = false;
        int maxAttempts = 10;
        int delaySeconds = 2;

        try {
          ProfileController profileController;
          if (Get.isRegistered<ProfileController>()) {
            profileController = Get.find<ProfileController>();
          } else {
            profileController = Get.put(ProfileController());
          }

          for (int attempt = 1; attempt <= maxAttempts; attempt++) {
            print(
              "--- Verifying premium membership status, attempt $attempt ---",
            );
            await profileController.fetchPremiumMembership();
            if (profileController.isPremium) {
              verified = true;
              break;
            }
            await Future.delayed(Duration(seconds: delaySeconds));
          }
        } catch (e) {
          print("Error refreshing premium status: $e");
        }

        // Close loading dialog
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        if (mounted) {
          if (verified) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text("Success"),
                    ],
                  ),
                  content: const Text(
                    "Thank you! Your premium membership payment was successful and activated.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.back();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: const Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange),
                      SizedBox(width: 10),
                      Text("Pending Activation"),
                    ],
                  ),
                  content: const Text(
                    "Your payment was successful, but activation is taking slightly longer to reflect. Please check your profile shortly.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.back();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      onFailure: (errorResponse) {
        print("--- Membership Payment Failed: ${errorResponse.message} ---");
        if (mounted) {
          final isCancelled =
              errorResponse.code == Razorpay.PAYMENT_CANCELLED ||
              errorResponse.code == 2;
          final displayMessage =
              isCancelled
                  ? "Payment cancelled."
                  : (errorResponse.message == null ||
                          errorResponse.message == "undefined" ||
                          errorResponse.message!.trim().isEmpty
                      ? "The payment could not be processed."
                      : errorResponse.message!);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(displayMessage),
              backgroundColor:
                  isCancelled ? Colors.orangeAccent : Colors.redAccent,
            ),
          );
        }
      },
    );
  }

  Future<void> fetchMembershipDetails() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      final dio = ApiConfigs.dio;
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.premiumMembership}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        final data = response.data['data'];
        if (data != null) {
          if (!mounted) return;
          setState(() {
            isPremiumUser =
                data['is_premium'] == true ||
                data['is_premium']?.toString() == "true" ||
                data['is_premium'] == 1 ||
                data['is_premium']?.toString() == "1";

            final amountVal = data['amount'];
            if (amountVal != null) {
              double? parsedAmount = double.tryParse(amountVal.toString());
              if (parsedAmount != null) {
                if (parsedAmount == parsedAmount.toInt()) {
                  price = parsedAmount.toInt();
                } else {
                  price = parsedAmount;
                }
              } else {
                price = amountVal;
              }
            }
          });
        }
      }
    } catch (e) {
      print("--- API Error (Membership Amount) ---");
      print("Error fetching membership details: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: premiumMembershipColor,
      appBar: NormalAppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        /* onTap: () {
          showComingSoonDialog(context);
        }, */
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
                    membershipDescription:
                        Strings.accidentalInsuranceDescription,
                    membershipName: Strings.accidentalInsurance,
                  ),
                  SizedBox(height: 10),
                  MemberShipCard(
                    icon:
                        "lib/Assets/Images/MembershipHMedicalHospitalFaciltyIcon.svg",
                    membershipDescription:
                        Strings.medicalHospFacilityDescription,
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
                  InkWell(
                    onTap: () async {
                      await handleMembershipPayment();
                    },
                    child: SubmitButtonWhite(amount: price),
                  ),
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
