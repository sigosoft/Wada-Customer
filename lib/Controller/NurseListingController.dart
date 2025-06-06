import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NurseListingController extends GetxController {
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
  final List<String> nurses = [
    "Nurse 1",
    "Nurse 2",
    "Nurse 3",
    "Nurse 4",
    "Nurse 5",
  ];
}