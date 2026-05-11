import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import '../../Controller/SettingsController.dart';
import '../../Resource/colors.dart';
import '../../Widgets/CustomAppBar.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        label: Strings.termsAndConditions,
        showCloseIcon: false,
      ),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.controller?.fetchTerms();
          });
        },
        builder: (controller) {
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: colorPrimary))
              : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    controller.termsContent,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: profileText,
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }
}
