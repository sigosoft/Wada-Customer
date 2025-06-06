import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../View/Ambulance/Ambulance.dart';
import '../View/Laboratory/Laboratory.dart';
import '../View/MedicalStore/MedicalStore.dart';

class ServiceListingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("ServiceListingController initialized");
  }

  @override
  void onClose() {
    print("ServiceListingController disposed");
    super.onClose();
  }


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

}