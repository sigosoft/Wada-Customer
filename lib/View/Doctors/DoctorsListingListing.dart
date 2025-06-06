import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Doctors/DoctorItem.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';

import '../../Controller/DoctorListingController.dart';
import '../../Resource/Colors.dart';



class DoctorsListingListing extends StatelessWidget {
  const DoctorsListingListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(label: Strings.doctors, showCloseIcon: false),
      body: GetBuilder<DoctorListingController>(
        init: DoctorListingController(),
        builder: (controller) => Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F8FD),
                    border: Border.all(color: Color(0xFFD8EBFF), width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        'lib/Assets/Images/search.svg',
                        color: profileText,
                        fit: BoxFit.scaleDown,
                      ),
                      hintText: Strings.searchDoctors,
                      hintStyle: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.doctors.length,
                  itemBuilder: (context, index) {
                    return DoctorItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}