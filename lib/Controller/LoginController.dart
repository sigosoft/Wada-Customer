import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
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
}
