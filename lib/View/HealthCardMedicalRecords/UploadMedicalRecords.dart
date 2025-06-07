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
import '../../Widgets/MemberDropdownField.dart';
import '../../Widgets/RelationshipDropdownField.dart';
import '../../Widgets/UploadRecordWidget.dart';
import '../../Widgets/UploadedFilesListView.dart';
import '../FamilyMember/SubmitButtonWithBorderColor.dart';

class UploadMedicalRecords extends StatefulWidget {
  const UploadMedicalRecords({super.key});

  @override
  State<UploadMedicalRecords> createState() => _UploadMedicalRecordsState();
}

class _UploadMedicalRecordsState extends State<UploadMedicalRecords> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(label: Strings.uploadmedicalRecords, showCloseIcon: false),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextStyleInterForSplash(
                text: Strings.chooseMember,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.0,
              ),
              SizedBox(height: 5),
              MemberDropdownField(),
              SizedBox(height: 15),
              TextInputWidget(label: Strings.recordName,type: TextInputType.text,height: 50),
              SizedBox(height: 15),
              TextInputWidget(label: Strings.notes,type: TextInputType.text,height: 80),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.uploadRecord,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.00,
              ),
              SizedBox(height: 10),
              TextStyleInterForSplash(
                text: Strings.documentFormat,
                color: blackTextColor,
                fontWeight: FontWeight.w500,
                size: 12.00,
              ),
              SizedBox(height: 15),
              UploadRecordWidget(),
              SizedBox(height: 10),
              Center(
                child: TextStyleInterForSplash(
                  text: Strings.or,
                  color: blackTextColor,
                  fontWeight: FontWeight.w500,
                  size: 14.00,
                ),
              ),
              SizedBox(height: 5),
              SubmitButtonWithBorderColor(
                text: Strings.openCamera,
              ),
              SizedBox(height: 10),
              TextStyleInterForSplash(
                text: Strings.uploaded,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.00,
              ),
              SizedBox(height: 10),
              UploadedFilesListView(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SubmitButtonWidget(
                  onTap:(){
          
                  },
                  text:Strings.save,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}




