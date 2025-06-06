import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:waada_customerapp/View/Ambulance/Ambulance.dart';
import 'package:waada_customerapp/View/BloodBank/BloodBankListing.dart';
import 'package:waada_customerapp/View/Doctors/DoctorsListingListing.dart';
import 'package:waada_customerapp/View/Laboratory/Laboratory.dart';
import 'package:waada_customerapp/View/MedicalStore/MedicalStore.dart';
import 'package:waada_customerapp/View/NurseBookings/BookNurse.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("HomeController initialized");
  }

  @override
  void onClose() {
    print("HomeController disposed");
    super.onClose();
  }
  int currentIndex = 0;
  int currentIndex2 = 0;




  final List<String> imageUrls = [
    'lib/Assets/Images/carousalSliderDummy.png',
    'lib/Assets/Images/carousalSliderDummy.png',
    'lib/Assets/Images/carousalSliderDummy.png',
  ];


  List<Map<String, String>> homeRowWidgetItems = [
    {
      'icon': "lib/Assets/Images/HomeScreenRowIcon1.svg",
      'name': 'Doctor',
      'description': 'Browse by specialty, availability, and location.'
    },
    {
      'icon': 'lib/Assets/Images/HomeScreenRowIcon2.svg',
      'name': 'Nurses',
      'description': 'Home care services & appointment booking.'
    },
    {
      'icon': 'lib/Assets/Images/HomeScreenRowIcon3.svg',
      'name': 'Blood Bank',
      'description': 'Home care services & appointment booking.'
    },
  ];


  List<Widget> screenWidgets = [
    DoctorsListingListing(),
    BookNurse(),
    BloodBankListing(),
  ];



  final List<Map<String, dynamic>> otherServicesList = [
    {
      'icon':"lib/Assets/Images/OtherServicesIcon1.svg",
      'name': 'Ambulance',
      'route': () => Get.to(() => Ambulance()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon2.svg",
      'name': 'Pathology Lab',
      'route': () => Get.to(() => Laboratory()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon3.svg",
      'name': 'Diagnostic Center',
      'route': () => Get.to(() => Ambulance()),
    },
    {
      'icon':"lib/Assets/Images/OtherServicesIcon4.svg",
      'name': 'Medical Equipment',
      'route': () => Get.to(() => Ambulance()),
    },
    {
      'icon':"lib/Assets/Images/OtherServicesIcon5.svg",
      'name': 'Medical Store',
      'route': () => Get.to(() => MedicalStore()),
    },
    {
      'icon': "lib/Assets/Images/OtherServicesIcon6.svg",
      'name': 'Laboratories',
      'route': () => Get.to(() => Laboratory()),
    },
  ];

  final List<String> imageUrls2 = [
    'lib/Assets/Images/homeSliderDummyImage.png',
    'lib/Assets/Images/homeSliderDummyImage.png',
    'lib/Assets/Images/homeSliderDummyImage.png',
  ];


}