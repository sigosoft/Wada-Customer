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

import '../../Controller/RegisterController.dart';
import '../../Widgets/AgreeWithTermsWidget.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/FadedPhonenumberField.dart';
import '../../Widgets/GenderDropdownField.dart';
import '../../Widgets/TextInputWidget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.editProfile, showCloseIcon: false),
      body: GetBuilder(
        init: Registercontroller(),
        builder:
            (controller) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: colorPrimary,
                        // Black border color
                        width: 3, // Thick border
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset('lib/Assets/Images/nurse.png')
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        // showImageDialog(context);
                      },
                      icon: SvgPicture.asset(
                        'lib/Assets/Images/editicon.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: 20,
                    child: IconButton(
                      onPressed: () {
                        // showImageDialog(context);
                      },
                      icon: SvgPicture.asset(
                        'lib/Assets/Images/redclose.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextInputWidget(label: Strings.firstname,type: TextInputType.text,height: 50),
              SizedBox(height: 15),
              TextInputWidget(label: Strings.email,type: TextInputType.emailAddress,height: 50),
              SizedBox(height: 15),
              FadedPhonenumberField(),
              SizedBox(height: 15),
              DateOfBirthField(),
              SizedBox(height: 15),
              GenderDropdownField(name: Strings.gender,),
              SizedBox(height: 100),
              SubmitButtonWidget(
                onTap:(){

                },
                text:Strings.save,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}




