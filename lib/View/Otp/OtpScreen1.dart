import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/PhoneNumberWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Resource/Colors.dart' show blackTextColor;


class OtpScreen1 extends StatefulWidget {
  const OtpScreen1({super.key});

  @override
  State<OtpScreen1> createState() => _OtpScreen1State();
}

class _OtpScreen1State extends State<OtpScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
  body: SingleChildScrollView(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GetBuilder<LoginController>(
        init: Get.isRegistered<LoginController>()
            ? Get.find<LoginController>()
            : Get.put(LoginController(), permanent: true),
          builder:(controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              TextStyleInterForSplash(
                text: Strings.forgotPassword,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 22.00,
              ),
              SizedBox(height: 20),
              TextStyleInterForSplash(
                text: Strings.enterTheNUmberLinkedWithYourAccount,
                color: blackTextColor,
                fontWeight: FontWeight.w500,
                size: 14.00,
              ),
              SizedBox(height: 20),
              CountryCodeAndPhoneNUmber(name: Strings.phoneNumber,),
              SizedBox(height: 20),
              SubmitButtonWidget(
                text: Strings.submit,
                onTap: (){
                  Get.to(OtpScreen2());
                },
              ),
            ],
          )),
    ),
  ),
    );
  }
}
