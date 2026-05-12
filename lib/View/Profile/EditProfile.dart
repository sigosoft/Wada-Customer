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

import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/Controller/ProfileController.dart';
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
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    // Reuse the already-registered controller. If not yet registered, create it.
    if (Get.isRegistered<ProfileController>()) {
      controller = Get.find<ProfileController>();
    } else {
      controller = Get.put(ProfileController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.editProfile, showCloseIcon: false),
      body: GetBuilder<ProfileController>(
        builder:
            (ctrl) => SingleChildScrollView(
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
                          border: Border.all(color: colorPrimary, width: 3),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:
                              ctrl.pickedImage != null
                                  ? Image.file(
                                    ctrl.pickedImage!,
                                    fit: BoxFit.cover,
                                  )
                                  : (ctrl.isImageRemoved ||
                                      ctrl.patientData?['image'] == null)
                                  ? Image.asset(
                                    'lib/Assets/Images/nurse.png',
                                    fit: BoxFit.cover,
                                  )
                                  : Image.network(
                                    "${ApiConfigs.IMAGE_URL}${ctrl.patientData!['image']}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'lib/Assets/Images/nurse.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                        ),
                      ),
                      Positioned(
                        right: -20,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            ctrl.pickImage();
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
                            ctrl.removeImage();
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
                  Form(
                    key: ctrl.formKey,
                    child: Column(
                      children: [
                        TextInputWidget(
                          label: Strings.firstname,
                          type: TextInputType.text,
                          height: 50,
                          controller: ctrl.nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextInputWidget(
                          label: Strings.email,
                          type: TextInputType.emailAddress,
                          height: 50,
                          controller: ctrl.emailController,
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
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  FadedPhonenumberField(
                    controller: ctrl.phoneController,
                    selectedCountryCode: ctrl.selectedCountryCode,
                    countryCodes: ctrl.countryCodes,
                    onCountryCodeChanged: (value) {
                      ctrl.selectedCountryCode = value;
                      ctrl.update();
                    },
                    onTap: () {
                      ctrl.fetchCountryCodes();
                    },
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
                  DateOfBirthField(controller: ctrl.dobController),
                  SizedBox(height: 15),
                  GenderDropdownField(
                    name: Strings.gender,
                    value: ctrl.selectedGender,
                    onChanged: (value) {
                      ctrl.selectedGender = value;
                      ctrl.update();
                    },
                  ),
                  SizedBox(height: 100),
                  ctrl.isLoading
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: colorPrimary,
                            strokeWidth: 3,
                          ),
                        )
                      : SubmitButtonWidget(
                        onTap: () {
                          ctrl.updateProfile();
                        },
                        text: Strings.save,
                      ),
                  SizedBox(height: 15),
                ],
              ),
            ),
      ),
    );
  }
}
