import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/HealthCardController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/FamilyMember/SubmitButtonWithBorderColor.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/CustomTabBarWidget.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/HealthCardRowWidget.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/UploadMedicalRecords.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';

class HealthCardMedicalRecords extends StatefulWidget {
  const HealthCardMedicalRecords({super.key});


  @override
  State<HealthCardMedicalRecords> createState() =>
      _HealthCardMedicalRecordsState();
}

class _HealthCardMedicalRecordsState extends State<HealthCardMedicalRecords> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.healthCard),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: HealthCardController(),
            builder:
                (controller) => Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HealthCardRowWidget(
                            text: Strings.medicalRecords,
                            textColor: controller.textColor1,
                            color: controller.boxColor1,
                            onTap: () {
                              controller.swapColors();
                            },
                          ),
                          HealthCardRowWidget(
                            text: Strings.consultationRecords,
                            textColor: controller.textColor2,
                            color: controller.boxColor2,
                            onTap: () {
                              controller.swapColors();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: CustomTabBarWidget(
                          itemList: controller.itemList,
                          controller: controller,
                          switchValue: controller.switchValue,
                          tabController: _tabController,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.switchValue==true,
                      child: SubmitButtonWithBorderColor(
                        onTap: () {
                          Get.to(UploadMedicalRecords());
                        },
                        text: Strings.upload,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}




