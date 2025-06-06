import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../Resource/Colors.dart';
import '../Resource/Strings.dart';
import '../View/Home/HomeNurseDetailsCardRowWidget.dart' show HomeNurseDetailsCardRowWidget;
import '../Widgets/widgets.dart';

class LaboratoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("LaboratoryController initialized");
  }

  @override
  void onClose() {
    print("LaboratoryController disposed");
    super.onClose();
  }


  void showLaboratoryDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStyleInterWithoutPadding(
                        text: "Apollo Diagnostics",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        size: 16.00,
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset("lib/Assets/Images/CloseIcon.svg"))
                    ],
                  ),
                  SizedBox(height: 20),
                  TextStyleInterWithoutPadding(
                    text:Strings.services,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    size: 16.00,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: HomeNurseDetailsCardRowWidget(
                                onTap: (){
                                  // _showCancelShiftBottomSheet(context);
                                },
                                color: premiumMembershipText,
                                date: "₹3,300",
                                type: "Liver function test",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  // _showCancelShiftBottomSheet(context);
                                },
                                child: HomeNurseDetailsCardRowWidget(
                                  color: premiumMembershipText,
                                  date: "₹2,500",
                                  type: "Full Body Checkup",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

}