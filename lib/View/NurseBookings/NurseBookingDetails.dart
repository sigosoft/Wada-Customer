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
        locationStr: args['location'] ?? "",
        latitudeStr: args['latitude']?.toString() ?? "",
        longitudeStr: args['longitude']?.toString() ?? "",
        amountStr: args['amount']?.toString() ?? "0",
      );
      controller.fetchHours();
    }
  }

  /// Returns null if the shift duration is valid, or an error message if not.
  String? _validateShiftDuration() {
    final checkinText = controller.checkinTimeController.text.trim();
    final checkoutText = controller.checkoutTimeController.text.trim();

    if (checkinText.isEmpty || checkoutText.isEmpty) {
      return "Please select check-in and check-out times";
    }

    // Parse a "hh:mm AM/PM" string into total minutes from midnight.
    int? parseToMinutes(String timeStr) {
      try {
        final parts = timeStr.split(' ');
        if (parts.length < 2) return null;
        final timeParts = parts[0].split(':');
        int hour = int.parse(timeParts[0]);
        final int minute = int.parse(timeParts[1]);
        final String ampm = parts[1].toUpperCase();
        if (ampm == 'PM' && hour < 12) hour += 12;
        if (ampm == 'AM' && hour == 12) hour = 0;
        return hour * 60 + minute;
      } catch (_) {
        return null;
      }
    }

    final int? checkinMinutes = parseToMinutes(checkinText);
    final int? checkoutMinutes = parseToMinutes(checkoutText);

    if (checkinMinutes == null || checkoutMinutes == null) {
      return "Invalid time format";
    }

    // Compute duration in minutes; handle overnight shifts.
    int durationMinutes = checkoutMinutes - checkinMinutes;
    if (durationMinutes <= 0) durationMinutes += 24 * 60;

    // Determine required hours from the selected shift type.
    final requiredHoursStr =
        controller.shiftHours
            .firstWhere(
              (h) => h['id'].toString() == controller.hourId,
              orElse: () => <String, dynamic>{},
            )['hour']
            ?.toString();

    if (requiredHoursStr == null) return null; // cannot determine, skip

    final int? requiredHours = int.tryParse(requiredHoursStr);
    if (requiredHours == null) return null;

    final int requiredMinutes = requiredHours * 60;
    if (durationMinutes != requiredMinutes) {
      return "The selected times must be exactly $requiredHours hour${requiredHours == 1 ? '' : 's'} apart for this shift type";
    }

    return null;
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
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: colorPrimary,
                  strokeWidth: 3,
                ),
              ),
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
                                  "${controller.shiftHours.firstWhere((h) => h['id'].toString() == controller.hourId, orElse: () => {'hour': '4'})['hour']} Hours",
                              text2: Strings.shifttype,
                              showInfoButton: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  controller
                                      .checkinTimeController
                                      .text = pickedTime.format(context);
                                  controller.update();
                                }
                              },
                              child: AbsorbPointer(
                                child: TextInputWidget(
                                  label: "Check-in Time",
                                  type: TextInputType.text,
                                  height: 50,
                                  controller: controller.checkinTimeController,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  controller
                                      .checkoutTimeController
                                      .text = pickedTime.format(context);
                                  controller.update();
                                }
                              },
                              child: AbsorbPointer(
                                child: TextInputWidget(
                                  label: "Check-out Time",
                                  type: TextInputType.text,
                                  height: 50,
                                  controller: controller.checkoutTimeController,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: "Choose Patient",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    MemberDropdownField(
                      members: controller.members,
                      selectedMemberId: controller.selectedMemberId,
                      onChanged: (id) {
                        controller.selectedMemberId = id;
                        controller.update();
                      },
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap: () {
                          if (controller.selectedMemberId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a patient"),
                              ),
                            );
                            return;
                          }
                          if (controller.selectedCategoryIds.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please select at least one service requirement",
                                ),
                              ),
                            );
                            return;
                          }

                          if (controller.checkinTimeController.text
                                  .trim()
                                  .isEmpty ||
                              controller.checkoutTimeController.text
                                  .trim()
                                  .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please select check-in and check-out times",
                                ),
                              ),
                            );
                            return;
                          }
                          final String? shiftError = _validateShiftDuration();
                          if (shiftError != null) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(shiftError)));
                            return;
                          }
                          Get.to(const RequestSending());
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
