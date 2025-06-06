import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DoctorListingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("LoginController initialized");
  }

  @override
  void onClose() {
    print("LoginController disposed");
    super.onClose();
  }
  final List<String> doctors = [
    "Doctor 1",
    "Doctor 2",
    "Doctor 3",
    "Doctor 4",
    "Doctor 5",
  ];
}