import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/Login.dart';
import 'package:waada_customerapp/View/Login/PasswordWidget.dart';
import 'package:waada_customerapp/View/Login/PhoneNumberWidget.dart';
import 'package:waada_customerapp/View/Login/RichTextWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen1.dart';
import 'package:waada_customerapp/View/Otp/OtpScreen2.dart';
import 'package:waada_customerapp/Widgets/DateOfBirthField.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Controller/RegisterController.dart';
import '../../Widgets/AgreeWithTermsWidget.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/GenderDropdownField.dart';
import '../../Widgets/TextInputWidget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: SvgPicture.asset(
            "lib/Assets/Images/BackButton.svg",
            fit: BoxFit.scaleDown,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        toolbarHeight: 50,
        centerTitle: false,
        actions: [
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
        init: Registercontroller(),
        builder:
            (controller) => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: controller.registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      TextStyleInterForSplash(
                        text: Strings.registration,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        size: 22.00,
                      ),
                      SizedBox(height: 20),
                      TextStyleInterForSplash(
                        text: Strings.createAccount,
                        color: blackTextColor,
                        fontWeight: FontWeight.w500,
                        size: 14.00,
                      ),
                      SizedBox(height: 20),
                      TextInputWidget(
                        controller: controller.firstNameController,
                        label: Strings.firstname,
                        type: TextInputType.text,
                        height: 50,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your first name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextInputWidget(
                        controller: controller.emailController,
                        label: Strings.email,
                        type: TextInputType.emailAddress,
                        height: 50,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          if (!GetUtils.isEmail(value.trim())) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CountryCodeAndPhoneNUmber(
                        name: Strings.phoneNumber,
                        countryValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Select code";
                          }
                          return null;
                        },
                        phoneValidator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your phone number";
                          }
                          if (value.length < 10) {
                            return "Phone number must be 10 digits";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      DateOfBirthField(controller: controller.dobController),
                      const SizedBox(height: 15),
                      GenderDropdownField(
                        name: Strings.gender,
                        onChanged: (value) {
                          controller.selectedGender = value;
                          controller.update();
                        },
                      ),
                      const SizedBox(height: 15),
                      TextInputWidget(
                        controller: controller.referralCodeController,
                        label: Strings.refferal_code,
                        type: TextInputType.text,
                        height: 50,
                      ),
                      const SizedBox(height: 15),
                      AgreeWithTermsWidget(
                        onChanged: (value) {
                          controller.isAgreedToTerms = value ?? false;
                          controller.update();
                        },
                      ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap: () {
                          controller.sendRegOtp();
                        },
                        text: Strings.verify,
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
