import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import 'package:waada_customerapp/View/Login/RichTextWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Map/ChooseLocation.dart';
import 'package:waada_customerapp/View/Otp/PinPutWidget.dart';
import 'package:waada_customerapp/View/Profile/Profile.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class OtpScreen2 extends StatefulWidget {
  const OtpScreen2({super.key});

  @override
  State<OtpScreen2> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpScreen2> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: LoginController(),
            builder:(controller) =>  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                TextStyleInterForSplash(
                  text: Strings.otpVerification,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 22.00,
                ),
                SizedBox(height: 20),
                TextStyleInterForSplash(
                  text: Strings.enterVerificationCodeSendToYourNumber,
                  color: blackTextColor,
                  fontWeight: FontWeight.w500,
                  size: 14.00,
                ),
                SizedBox(height: 30),
                PinPutWidget(),
                SizedBox(height: 30),
                SubmitButtonWidget(
                  text: Strings.verify,
                  onTap: (){
                      Get.to(ChooseLocation());
                  },
                ),
                SizedBox(height: 20),
                RichTextWidget(
                  text1:Strings.didNotReceiveCode,
                  text2: Strings.resend,
                  onTap:(){
        
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


