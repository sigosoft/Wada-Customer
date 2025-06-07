import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/HealthcardMedicalRecords.dart';
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
import '../../Widgets/BloodGroupDropDownField.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/GenderDropdownField.dart';
import '../../Widgets/TextInputWidget.dart';

class CompleteHealthCards extends StatefulWidget {
  const CompleteHealthCards({super.key});

  @override
  State<CompleteHealthCards> createState() => _CompleteHealthCardsState();
}

class _CompleteHealthCardsState extends State<CompleteHealthCards> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(label: Strings.healthCard, showCloseIcon: false),
      body: SingleChildScrollView(
                child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          TextStyleInterForSplash(
            text: Strings.completehealthcard,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            size: 20.00,
          ),
          SizedBox(height: 20),
          TextStyleInterForSplash(
            text: Strings.healthcardDescription,
            color: blackTextColor,
            fontWeight: FontWeight.w500,
            size: 13.00,
          ),
          SizedBox(height: 20),
          TextInputWidget(label: Strings.firstname,type: TextInputType.text,height: 50),
          SizedBox(height: 15),
          DateOfBirthField(),
          SizedBox(height: 15),
          GenderDropdownField(name: Strings.genderwithstar,),
          SizedBox(height: 15),
          BloodGroupDropDownField(),
          SizedBox(height: 15),
          CountryCodeAndPhoneNUmber(name: Strings.phonenumberwithstar,),
          SizedBox(height: 15),
          TextInputWidget(label: Strings.fullAddress,type: TextInputType.text,height: 80),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SubmitButtonWidget(
              onTap:(){
                Get.to(HealthCardMedicalRecords());
              },
              text:Strings.save,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
                ),
              ),
    );
  }
}




