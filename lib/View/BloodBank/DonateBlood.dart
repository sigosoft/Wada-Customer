import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/DonateBloodController.dart';
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

class DonateBlood extends StatefulWidget {
  const DonateBlood({super.key});

  @override
  State<DonateBlood> createState() => _DonateBloodState();
}

class _DonateBloodState extends State<DonateBlood> {
  @override
  void initState() {
    super.initState();
    Get.put(DonateBloodController());
  }

  void _showLocationBottomSheet(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    List<String> _searchResults = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      // ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _onSearchChanged(String query) {
              setState(() {
                _searchResults =
                    query.isEmpty
                        ? []
                        : List.generate(5, (index) => "$query Result $index");
              });
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Back Button
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          "lib/Assets/Images/BackButton.svg",
                          fit: BoxFit.scaleDown,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        Strings.chooseLocation,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Search Box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Icon(Icons.search, color: Colors.grey),
                        // SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: InputDecoration(
                              hintText: Strings.chooseLocation,
                              hintStyle: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              fillColor: const Color(0xFFF3F3F3),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Popular Searches or Search Results
                  SizedBox(
                    height: 300, // Set a fixed height for the ListView
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'lib/Assets/Images/locationIcon.svg',
                                    width: 20,
                                    height: 20,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _searchResults[index],
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 1,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E5E5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.donateblood, showCloseIcon: false),
      body: GetBuilder<DonateBloodController>(
        builder:
            (controller) => SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          TextInputWidget(
                            label: Strings.donarname,
                            type: TextInputType.text,
                            height: 50,
                            controller: controller.nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter donor name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: BloodGroupDropDownField(
                                  onChanged: (value) {
                                    controller.selectedBloodGroup = value;
                                    controller.update();
                                  },
                                ),
                              ),
                              Expanded(
                                child: GenderDropdownField(
                                  name: Strings.genderwithstar,
                                  onChanged: (value) {
                                    controller.selectedGender = value;
                                    controller.update();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const CountryCodeAndPhoneNUmber(
                            name: Strings.phonenumberwithstar,
                            phoneValidator: null, // Uses default if needed
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              _showLocationBottomSheet(context);
                            },
                            child: TextInputWidget(
                              label: Strings.yourlocation,
                              type: TextInputType.text,
                              height: 50,
                              controller: controller.locationController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please select location";
                                }
                                return null;
                              },
                              onTap: () {
                                _showLocationBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SubmitButtonWidget(
                      onTap: () {
                        if (controller.selectedBloodGroup == null) {
                          Get.snackbar(
                            "Error",
                            "Please select blood group",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }
                        if (controller.selectedGender == null) {
                          Get.snackbar(
                            "Error",
                            "Please select gender",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }
                        if (controller.formKey.currentState!.validate()) {
                          _showInfoBottomSheet(context);
                        }
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

  void _showInfoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                Strings.infomsg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: profileText,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    Strings.ok,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
