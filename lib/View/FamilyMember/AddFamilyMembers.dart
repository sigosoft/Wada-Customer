import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/FamilyMemberController.dart';
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
import '../../Widgets/BloodGroupDropDownField.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/GenderDropdownField.dart';
import '../../Widgets/TextInputWidget.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../../Widgets/RelationshipDropdownField.dart';

class AddFamilyMembers extends StatefulWidget {
  const AddFamilyMembers({super.key});

  @override
  State<AddFamilyMembers> createState() => _AddFamilyMembersState();
}

class _AddFamilyMembersState extends State<AddFamilyMembers> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FamilyMemberController>(
      init: FamilyMemberController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.controller?.fetchCountryCodes();
        });
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            label:
                controller.isEditMode
                    ? "Update Details"
                    : Strings.addfamilymembers,
            showCloseIcon: false,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    RelationshipDropdownField(
                      value: controller.relationId,
                      onChanged: (val) {
                        controller.relationId = val;
                        controller.update();
                      },
                    ),
                    SizedBox(height: 15),
                    TextInputWidget(
                      label: Strings.firstname,
                      type: TextInputType.text,
                      height: 50,
                      controller: controller.nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    DateOfBirthField(controller: controller.dobController),
                    SizedBox(height: 15),
                    GenderDropdownField(
                      name: Strings.genderwithstar,
                      value: controller.gender,
                      onChanged: (val) {
                        controller.gender = val;
                        controller.update();
                      },
                    ),
                    SizedBox(height: 15),
                    CountryCodeAndPhoneNUmber(
                      name: Strings.phonenumberwithstar,
                      phoneValidator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter phone number";
                        }
                        if (value.length < 10) {
                          return "Phone number must be 10 digits";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextInputWidget(
                      label: Strings.fullAddress,
                      type: TextInputType.text,
                      height: 80,
                      controller: controller.addressController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    CheckboxWdget(
                      content: Strings.emergencycontact,
                      size: 14,
                      color: colorPrimary,
                      isChecked: controller.isEmergencyContact,
                      onChanged: (val) {
                        controller.isEmergencyContact = val ?? false;
                        controller.update();
                      },
                    ),
                    CheckboxWdget(
                      content: Strings.decalration,
                      size: 12,
                      color: colorPrimary,
                      isChecked:
                          true, // Assuming declaration is always true for save
                    ),
                    SizedBox(height: 50),
                    controller.isLoading.value
                        ? const Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: colorPrimary,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                        : SubmitButtonWidget(
                          onTap: () {
                            if (controller.isEditMode) {
                              controller.updateMember();
                            } else {
                              controller.addMember();
                            }
                          },
                          text: Strings.save,
                        ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
