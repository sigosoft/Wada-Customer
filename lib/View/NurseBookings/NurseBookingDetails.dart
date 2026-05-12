import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/NurseBookings/RequestSending.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../../Widgets/MemberDropdownField.dart';
import '../../Widgets/TextInputWidget.dart';
import '../../Controller/NurseBookingController.dart';
import 'package:get/get.dart';

class NurseBookingDetails extends StatefulWidget {
  const NurseBookingDetails({super.key});

  @override
  State<NurseBookingDetails> createState() => _NurseBookingDetailsState();
}

class _NurseBookingDetailsState extends State<NurseBookingDetails> {
  final NurseBookingController controller = Get.put(NurseBookingController());

  @override
  void initState() {
    super.initState();
    //checkintimeController.text = "09:30 AM";
    //checkouttimeController.text = "05:00 PM";

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      controller.fetchNurseDetails(
        int.tryParse(args['nurse_id'].toString()) ?? 0,
        args['start_date'] ?? "",
        args['end_date'] ?? "",
        args['hour_id']?.toString() ?? "1",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.details, showCloseIcon: false),
      body: GetBuilder<NurseBookingController>(
        builder: (controller) {
          if (controller.isDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          return SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    NurseDetailsWidget(
                      showPartiallyAvailable: true,
                      nurseData: controller.nurseData,
                    ),
                    const SizedBox(height: 10),
                    TextStyleInterForSplash(
                      text: Strings.shiftdetails,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: controller.fromDate,
                              text2: Strings.checkindate,
                              showInfoButton: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: controller.toDate,
                              text2: Strings.checkoutdate,
                              showInfoButton: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1:
                                  controller.hourId == '1'
                                      ? "4 Hours"
                                      : controller.hourId == '2'
                                      ? "8 Hours"
                                      : controller.hourId == '3'
                                      ? "12 Hours"
                                      : "24 Hours",
                              text2: Strings.shifttype,
                              showInfoButton: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.selectserviceRequirement,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    // Categories fetched dynamically
                    Column(
                      children:
                          controller.categories.map((category) {
                            return CheckboxWdget(
                              content: category['category_name'] ?? "",
                              size: 13,
                              color: Colors.black,
                              isChecked: controller.isCategorySelected(
                                category['id'],
                              ),
                              onChanged: (value) {
                                controller.toggleCategory(category['id']);
                              },
                            );
                          }).toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: Form(
                        key: controller.formKey,
                        child: TextInputWidget(
                          controller: controller.notesController,
                          label: Strings.notes,
                          type: TextInputType.text,
                          height: 80,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter notes";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap: () {
                          if (controller.selectedCategoryIds.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please select at least one service requirement",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }
                          if (controller.formKey.currentState!.validate()) {
                            Get.to(const RequestSending());
                          }
                        },
                        text: Strings.confirm,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
