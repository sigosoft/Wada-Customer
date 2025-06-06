import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/PhoneNumberWidget.dart';
import 'package:waada_customerapp/View/Login/RichTextWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';

import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';
import 'package:waada_customerapp/Widgets/AppBarWithoutElevation.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../Register/Register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading:SizedBox(),
        titleSpacing: 0,
        toolbarHeight: 50,
        centerTitle: false,
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                "lib/Assets/Images/CloseIcon.svg",
                fit: BoxFit.scaleDown,
                color: Colors.black,
              ),
            ),
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: GetBuilder(
        init: LoginController(),
        builder:
            (controller) => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    TextStyleInterForSplash(
                      text: Strings.signInWithPhoneNumber,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 22.00,
                    ),
                    SizedBox(height: 20),
                    TextStyleInterForSplash(
                      text: Strings.enterYourPhoneNumber,
                      color: blackTextColor,
                      fontWeight: FontWeight.w500,
                      size: 14.00,
                    ),
                    SizedBox(height: 20),
                    CountryCodeAndPhoneNUmber(name: Strings.phoneNumber,),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap:(){
                          Get.to(OtpScreen2 ());
                        },
                        text:Strings.next,
                      ),
                    ),
                    SizedBox(height: 15),
                   RichTextWidget(
                     text1:Strings.donHaveAnAccount,
                     text2: Strings.register,
                     onTap:(){
                       Get.to(Register());
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




