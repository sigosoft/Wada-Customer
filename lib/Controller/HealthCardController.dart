import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class HealthCardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("HealthCardController initialized");
  }

  @override
  void onClose() {
    print("HealthCardController disposed");
    super.onClose();
  }


  Color boxColor1 =colorPrimary;
  Color textColor1 =Colors.white;
  Color boxColor2 =colorPrimaryWith25Opacity;
  Color textColor2 =colorPrimary;
  double sizedBoxHeight = 150.00;
  bool switchValue=true;

  void swapColors() {
    final tempBoxColor = boxColor1;
    final tempTextColor = textColor1;
    boxColor1 = boxColor2;
    textColor1 = textColor2;
    boxColor2 = tempBoxColor;
    textColor2 = tempTextColor;
    switchValue=!switchValue;
    sizedBoxHeight =150;
    update();
  }
  List<String>attatchmentList = [
    'lib/Assets/Images/attatchmentDummy.png',
    'lib/Assets/Images/attatchmentDummy.png',
    'lib/Assets/Images/attatchmentDummy.png',
  ];

  List<String> itemList=[
    "All",
    "George Jacob",
    "Merlin Thomas ",
    "Thomas James",
    "John Doe",
  ];









}