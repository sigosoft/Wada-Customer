import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/PasswordWidget.dart';
import 'package:waada_customerapp/View/Login/PhoneNumberWidget.dart';
import 'package:waada_customerapp/View/Login/RichTextWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen1.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';
import 'package:waada_customerapp/Widgets/DateOfBirthField.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../../Controller/RegisterController.dart';
import '../../../Widgets/AgreeWithTermsWidget.dart';
import '../../../Widgets/BloodGroupDropDownField.dart';
import '../../../Widgets/CustomAppBar.dart';
import '../../../Widgets/GenderDropdownField.dart';
import '../../../Widgets/TextInputWidget.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../../Widgets/RelationshipDropdownField.dart';

class Referral extends StatefulWidget {
  const Referral({super.key});

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.refferal, showCloseIcon: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: borderLine, // Background color
              borderRadius: BorderRadius.circular(10), // Rounded edges
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextStyleInterForSplash(
                  text: Strings.refferals,
                  fontWeight: FontWeight.w400,
                  color: profileText, // Black text color
                  size: 13.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          TextStyleInterForSplash(
                            text: "546321",
                            fontWeight: FontWeight.w700,
                            color: profileText, // Black text color
                            size: 20.0,
                          ),
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'lib/Assets/Images/copy1.svg',
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'lib/Assets/Images/copy2.svg',
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextStyleInterForSplash(
            text: Strings.dummy,
            fontWeight: FontWeight.w400,
            color: profileText, // Black text color
            size: 13.0,
          ),
        ],
      ),
    );
  }
}
