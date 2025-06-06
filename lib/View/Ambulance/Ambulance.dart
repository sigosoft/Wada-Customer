import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/AmbulanceController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/RequestSentSuccess.dart';
import 'package:waada_customerapp/Widgets/AmbulanceDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';
import 'package:waada_customerapp/Widgets/SearchbardWidget.dart';

class Ambulance extends StatefulWidget {
  const Ambulance({super.key});

  @override
  State<Ambulance> createState() => _AmbulanceState();
}

class _AmbulanceState extends State<Ambulance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.ambulance, showCloseIcon: false),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder(
          init: AmbulanceController(),
          builder:
              (controller) => Column(
                children: [
                  SearchBarWidget(labelText: Strings.searchAmbulance),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return AmbulanceDetailsWidget(
                          onAllServicesTapped: () {
                           controller.showCancelShiftBottomSheet(context);
                          },
                          buttonText: Strings.bookNow,
                          moreOptions: index % 2 == 0,
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: 20),
                      itemCount: 2,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
        ),
      ),
    );
  }
}





