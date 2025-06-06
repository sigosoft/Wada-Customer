import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/ServiceListingController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Home/OtherServicesGridWidget.dart';

import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/widgets.dart';

class ServiceListing extends StatefulWidget {
  const ServiceListing({super.key});

  @override
  State<ServiceListing> createState() => _ServiceListingState();
}

class _ServiceListingState extends State<ServiceListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 0,
        leading: Container(),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: TextStyleInterForSplash(
          text: Strings.chooseYourService,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
        toolbarHeight: 50,
        titleSpacing: 5.0, // Adjust this value to reduce the gap
        elevation:0,
        scrolledUnderElevation: 0.0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
          child: GetBuilder(
            init: ServiceListingController(),
            builder:(controller) => OtherServicesGrid(
              otherServicesList:controller.otherServicesList,
            )
          ),
        ),
      ));

  }
}
