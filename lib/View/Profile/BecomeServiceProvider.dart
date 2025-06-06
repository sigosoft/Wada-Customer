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
import '../../Widgets/ServiceDownField.dart';

class BecomeServiceProvider extends StatefulWidget {
  const BecomeServiceProvider({super.key});

  @override
  State<BecomeServiceProvider> createState() => _BecomeServiceProviderState();
}

class _BecomeServiceProviderState extends State<BecomeServiceProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.becomeserviceProvider, showCloseIcon: false),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    TextStyleInterForSplash(
                      text: Strings.chooseService,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    SizedBox(height: 15),
                    ServiceDownField(),
                    SizedBox(height: 15),
                    TextInputWidget(label: Strings.firstname, type: TextInputType.text, height: 50),
                    SizedBox(height: 15),
                    CountryCodeAndPhoneNUmber(name: Strings.phonenumberwithstar),
                    SizedBox(height: 15),
                    TextInputWidget(label: Strings.fullAddress, type: TextInputType.text, height: 80),
                    SizedBox(height: 15),
                    TextInputWidget(label: Strings.notes, type: TextInputType.text, height: 80),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: SubmitButtonWidget(
                  onTap: () {

                  },
                  text: Strings.sent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




