import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Controller/RegisterController.dart';

import 'package:waada_customerapp/Controller/DonateBloodController.dart';
import 'package:waada_customerapp/Controller/FamilyMemberController.dart';
import 'package:waada_customerapp/Utils/HelperFunctions.dart';

class CountryCodeAndPhoneNUmber extends StatelessWidget {
  const CountryCodeAndPhoneNUmber({
    super.key,
    required this.name,
    this.phoneValidator,
    this.countryValidator,
    this.controller,
  });
  final String name;
  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? countryValidator;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    final String? selectedCountryCode =
        controller != null
            ? controller.selectedCountryCode
            : (Get.isRegistered<FamilyMemberController>()
                ? Get.find<FamilyMemberController>().selectedCountryCode
                : Get.isRegistered<DonateBloodController>()
                ? Get.find<DonateBloodController>().selectedCountryCode
                : Get.isRegistered<Registercontroller>()
                ? Get.find<Registercontroller>().selectedCountryCode
                : Get.isRegistered<LoginController>()
                ? Get.find<LoginController>().selectedCountryCode
                : null);
    final int phoneLength = getPhoneNumberLength(selectedCountryCode);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      validator: countryValidator,
                      onTap: () {
                        if (controller != null) {
                          controller.fetchCountryCodes();
                        } else {
                          if (Get.isRegistered<FamilyMemberController>()) {
                            Get.find<FamilyMemberController>()
                                .fetchCountryCodes();
                          } else if (Get.isRegistered<
                            DonateBloodController
                          >()) {
                            Get.find<DonateBloodController>()
                                .fetchCountryCodes();
                          } else if (Get.isRegistered<Registercontroller>()) {
                            Get.find<Registercontroller>().fetchCountryCodes();
                          } else if (Get.isRegistered<LoginController>()) {
                            Get.find<LoginController>().fetchCountryCodes();
                          }
                        }
                      },
                      value:
                          controller != null
                              ? controller.selectedCountryCode
                              : (Get.isRegistered<FamilyMemberController>()
                                  ? Get.find<FamilyMemberController>()
                                      .selectedCountryCode
                                  : Get.isRegistered<DonateBloodController>()
                                  ? Get.find<DonateBloodController>()
                                      .selectedCountryCode
                                  : Get.isRegistered<Registercontroller>()
                                  ? Get.find<Registercontroller>()
                                      .selectedCountryCode
                                  : Get.isRegistered<LoginController>()
                                  ? Get.find<LoginController>()
                                      .selectedCountryCode
                                  : null),
                      hint: Text(
                        Strings.countryCode,
                        style: GoogleFonts.inter(
                          color: blackTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                      icon: const SizedBox.shrink(),
                      isExpanded: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF3F3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        errorStyle: const TextStyle(height: 0, fontSize: 0),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items:
                          (controller != null
                                  ? controller.countryCodes
                                  : (Get.isRegistered<FamilyMemberController>()
                                      ? Get.find<FamilyMemberController>()
                                          .countryCodes
                                      : Get.isRegistered<
                                        DonateBloodController
                                      >()
                                      ? Get.find<DonateBloodController>()
                                          .countryCodes
                                      : Get.isRegistered<Registercontroller>()
                                      ? Get.find<Registercontroller>()
                                          .countryCodes
                                      : Get.isRegistered<LoginController>()
                                      ? Get.find<LoginController>().countryCodes
                                      : []))
                              .map<DropdownMenuItem<String>>((code) {
                                return DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(
                                    code,
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                      onChanged: (value) {
                        if (controller != null) {
                          controller.selectedCountryCode = value;
                          int index = controller.countryCodes.indexOf(value!);
                          if (index != -1) {
                            if (controller is FamilyMemberController) {
                              controller.countryCodeId =
                                  controller.countryIds[index].toString();
                            } else {
                              controller.selectedCountryId =
                                  controller.countryIds[index];
                            }
                          }
                          controller.update();
                        } else {
                          if (Get.isRegistered<FamilyMemberController>()) {
                            var fmController =
                                Get.find<FamilyMemberController>();
                            fmController.selectedCountryCode = value;
                            int index = fmController.countryCodes.indexOf(
                              value!,
                            );
                            if (index != -1) {
                              fmController.countryCodeId =
                                  fmController.countryIds[index].toString();
                            }
                            fmController.update();
                          } else if (Get.isRegistered<
                            DonateBloodController
                          >()) {
                            DonateBloodController controller =
                                Get.find<DonateBloodController>();
                            controller.selectedCountryCode = value;
                            int index = controller.countryCodes.indexOf(value!);
                            if (index != -1) {
                              controller.selectedCountryId =
                                  controller.countryIds[index];
                            }
                            controller.update();
                          } else if (Get.isRegistered<Registercontroller>()) {
                            Registercontroller controller =
                                Get.find<Registercontroller>();
                            controller.selectedCountryCode = value;
                            int index = controller.countryCodes.indexOf(value!);
                            if (index != -1) {
                              controller.selectedCountryId =
                                  controller.countryIds[index];
                            }
                            controller.update();
                          } else if (Get.isRegistered<LoginController>()) {
                            LoginController controller =
                                Get.find<LoginController>();
                            controller.selectedCountryCode = value;
                            int index = controller.countryCodes.indexOf(value!);
                            if (index != -1) {
                              controller.selectedCountryId =
                                  controller.countryIds[index];
                            }
                            controller.update();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: phoneValidator,
                        controller:
                            controller != null
                                ? (controller is FamilyMemberController
                                    ? controller.mobileController
                                    : controller.phoneController)
                                : (Get.isRegistered<DonateBloodController>()
                                    ? Get.find<DonateBloodController>()
                                        .phoneController
                                    : Get.isRegistered<Registercontroller>()
                                    ? Get.find<Registercontroller>()
                                        .phoneController
                                    : Get.isRegistered<LoginController>()
                                    ? Get.find<LoginController>()
                                        .phoneController
                                    : Get.isRegistered<FamilyMemberController>()
                                    ? Get.find<FamilyMemberController>()
                                        .mobileController
                                    : null),
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(phoneLength),
                        ],
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          labelText: name,
                          labelStyle: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            color: blackTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF3F3F3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          errorStyle: const TextStyle(height: 0, fontSize: 0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          if (value.length > phoneLength) {
                            value = value.substring(0, phoneLength);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
