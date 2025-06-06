import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

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

  final List<Map<String, String>> coupons = [
    {
      "title": "30% Off",
      "description": "Get 30% Off when you book for more than 30 days!",
    },
    {
      "title": "20% Off",
      "description": "Get 20% Off when you book for more than 15 days!",
    },
    {
      "title": "10% Off",
      "description": "Get 10% Off when you book for more than 7 days!",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: Strings.coupons, showCloseIcon: false),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15, top: 20, bottom: 80),
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
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("lib/Assets/Images/offer.svg",height: 25,width: 25,),
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
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (!states.contains(MaterialState.selected)) {
                                return colorPrimary; // Inactive border color
                              }
                              return colorPrimary; // Active color
                            },
                          ),
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
      floatingActionButton:  Container(
        margin: EdgeInsets.only(bottom: 10,left: 5,right: 5),
        child: SubmitButtonWidget(
          onTap:(){
            _showCustomBottomSheet(context);
          },
          text:Strings.updateCoupon,
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
                      style:  GoogleFonts.inter(
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
                            "Get 30% Off when you book for more than 30 days!",
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
                left: MediaQuery.of(context).size.width / 2 - 30, // Center horizontally
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.black,size: 30,),
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