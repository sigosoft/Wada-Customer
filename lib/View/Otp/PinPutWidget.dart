import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pinput/pinput.dart';
import 'package:waada_customerapp/Controller/LoginController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class PinPutWidget extends StatelessWidget {
  const PinPutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Pinput(
          length: 6,
          controller: Get.find<LoginController>().otpController,
          defaultPinTheme: PinTheme(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: greyBg,
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
