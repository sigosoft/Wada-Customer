import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../Configs/ApiConfigs.dart';
import '../Membership/MemberShipScreen.dart';
import '../../Controller/NurseBookingController.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/CustomAppBar.dart';
import '../Login/SubmitButtonWidget.dart';

class CouponsListing extends StatefulWidget {
  const CouponsListing({Key? key}) : super(key: key);

  @override
  State<CouponsListing> createState() => _CouponsListingState();
}

class _CouponsListingState extends State<CouponsListing> {
  int selectedCouponIndex = -1;
  bool isLoading = false;
  List<Map<String, String>> coupons = [];

  @override
  void initState() {
    super.initState();
    fetchCoupons();
  }

  Future<void> fetchCoupons() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      final Dio dio = ApiConfigs.dio;
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.coupons}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 &&
          response.data['status'].toString() == "true") {
        final List<dynamic> data = response.data['data'] ?? [];
        if (!mounted) return;
        setState(() {
          coupons =
              data.map<Map<String, String>>((item) {
                final title = item['title']?.toString() ?? '';
                final code = item['code']?.toString() ?? '';
                final discountVal =
                    item['discount value'] ?? item['discount_value'];
                final type = item['type'];
                final minDays = item['min_days'];

                String discountStr = "";
                if (discountVal != null) {
                  double? val = double.tryParse(discountVal.toString());
                  if (val != null) {
                    if (val == val.toInt()) {
                      discountStr =
                          type.toString() == "2"
                              ? "${val.toInt()}%"
                              : "₹${val.toInt()}";
                    } else {
                      discountStr = type.toString() == "2" ? "$val%" : "₹$val";
                    }
                  } else {
                    discountStr =
                        type.toString() == "2"
                            ? "$discountVal%"
                            : "₹$discountVal";
                  }
                }

                String conditionStr = "";
                if (minDays != null && minDays.toString() != "null") {
                  conditionStr = " when you book for more than $minDays days";
                }

                final description =
                    "Get $discountStr Off$conditionStr! Use code $code";

                return {
                  "title": title,
                  "description": description,
                  "code": code,
                };
              }).toList();
        });
      }
    } catch (e) {
      print("--- API Error (Fetch Coupons) ---");
      print("Error fetching coupons: $e");
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.coupons, showCloseIcon: false),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: colorPrimary))
              : coupons.isEmpty
              ? Center(
                child: Text(
                  "No coupons available",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                  top: 20,
                  bottom: 80,
                ),
                child: ListView.builder(
                  itemCount: coupons.length,
                  itemBuilder: (context, index) {
                    final coupon = coupons[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCouponIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAEFFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "lib/Assets/Images/offer.svg",
                                  height: 25,
                                  width: 25,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  coupon["title"]!,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                Radio<int>(
                                  activeColor: colorPrimary,
                                  fillColor: MaterialStateProperty.resolveWith<
                                    Color
                                  >((Set<MaterialState> states) {
                                    if (!states.contains(
                                      MaterialState.selected,
                                    )) {
                                      return colorPrimary; // Inactive border color
                                    }
                                    return colorPrimary; // Active color
                                  }),
                                  value: index,
                                  groupValue: selectedCouponIndex,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCouponIndex = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              coupon["description"]!,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: blackTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: SubmitButtonWidget(
          onTap: () async {
            if (selectedCouponIndex == -1) {
              Get.snackbar(
                "Select Coupon",
                "Please select a coupon first",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
              return;
            }

            // Show loading dialog
            Get.dialog(
              const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
              barrierDismissible: false,
            );

            bool isPremium = false;
            try {
              final prefs = await SharedPreferences.getInstance();
              final String? token = prefs.getString('auth_token');
              String url = "${ApiConfigs.BASE_URL}premium/membership";

              final headers = {
                'Accept': 'application/json',
                if (token != null) 'Authorization': 'Bearer $token',
              };

              final response = await ApiConfigs.dio.get(
                url,
                options: Options(headers: headers),
              );

              if (response.statusCode == 200 &&
                  response.data['status'].toString() == "true") {
                final data = response.data['data'];
                if (data != null) {
                  isPremium =
                      data['is_premium'] == true ||
                      data['is_premium']?.toString() == "true" ||
                      data['is_premium'] == 1 ||
                      data['is_premium']?.toString() == "1";
                }
              }
            } catch (e) {
              print("Error checking premium status in CouponsListing: $e");
            }

            // Close loading dialog
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }

            if (isPremium) {
              // Apply the coupon
              if (Get.isRegistered<NurseBookingController>()) {
                final nurseBookingController =
                    Get.find<NurseBookingController>();

                // Show loading dialog while calling applyCouponApi
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                  barrierDismissible: false,
                );

                final success = await nurseBookingController.applyCouponApi(
                  coupons[selectedCouponIndex]['code']!,
                );

                // Close loading dialog
                if (Get.isDialogOpen ?? false) {
                  Get.back();
                }

                if (success) {
                  // Go back to the /RequestSending page
                  Get.back();
                }
              } else {
                Get.back();
              }
            } else {
              // Show bottom sheet to join wada premium membership
              _showCustomBottomSheet(context);
            }
          },
          text: Strings.updateCoupon,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Make the background transparent
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorPrimary, colorPrimaryDark],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      Strings.wadaspecialdiscounts,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textcolor2,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2F84C8), Color(0xFF174162)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFF2F84C8)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "lib/Assets/Images/wadaoffer.svg",
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(height: 5),
                          Text(
                            selectedCouponIndex >= 0 &&
                                    selectedCouponIndex < coupons.length
                                ? coupons[selectedCouponIndex]["description"]!
                                : "Get 30% Off when you book for more than 30 days!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: textcolor1,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Exciting Offers & Discounts Await You!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textcolor,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonbg,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Get.to(const MemberShipScreen());
                        },
                        child: Text(
                          Strings.joinwadapremium,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: bluetext,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                top: -70, // Position above the center
                left:
                    MediaQuery.of(context).size.width / 2 -
                    30, // Center horizontally
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.black, size: 30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
