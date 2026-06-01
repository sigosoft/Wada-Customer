import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/NurseBookingController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/RequestSentSuccess.dart';
import 'package:waada_customerapp/Widgets/NurseDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/ShiftDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/CheckboxWdget.dart';
import '../../Widgets/CouponWidget.dart';

class RequestSending extends StatefulWidget {
  const RequestSending({super.key});

  @override
  State<RequestSending> createState() => _RequestSendingState();
}

class _RequestSendingState extends State<RequestSending> {
  final NurseBookingController controller = Get.find<NurseBookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.details, showCloseIcon: false),
      body: GetBuilder<NurseBookingController>(
        builder: (controller) {
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
                            child: ShiftDetailsWidget(
                              text1: controller.checkinTimeController.text,
                              text2: "Check-in Time",
                              showInfoButton: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ShiftDetailsWidget(
                              text1: controller.checkoutTimeController.text,
                              text2: "Check-out Time",
                              showInfoButton: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.patientdetails,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: RichText(
                        text: TextSpan(
                          text:
                              controller.selectedMember?['name'] ??
                              'Select Patient',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                          children: [
                            if (controller.selectedMember != null)
                              TextSpan(
                                text:
                                    ' ${controller.selectedMember?['dob'] != null ? (DateTime.now().year - DateTime.parse(controller.selectedMember!['dob']).year) : ""} (${controller.selectedMember?['gender'] == 1 ? "M" : "F"})',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                      ),
                      child: Text(
                        controller.selectedMember?['mobile'] ?? '',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.serviceRequirement,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    // Display selected categories
                    ...controller.categories
                        .where(
                          (cat) => controller.selectedCategoryIds.contains(
                            cat['id'],
                          ),
                        )
                        .map(
                          (cat) => CheckboxWdget(
                            content: cat['category_name'] ?? "",
                            size: 13,
                            color: Colors.black,
                            isChecked: true,
                          ),
                        ),
                    const SizedBox(height: 5),
                    TextStyleInterForSplash(
                      text: Strings.notes,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        controller.notesController.text,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CouponWidget(),
                    const SizedBox(height: 15),
                    TextStyleInterForSplash(
                      text: Strings.billdetails,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 15.00,
                    ),
                    const SizedBox(height: 10),
                    // Bill details logic could be more complex, using placeholders for now
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextStyleInterForSplash(
                            text:
                                "${controller.shiftHours.firstWhere((h) => h['id'].toString() == controller.hourId, orElse: () => {'hour': '4'})['hour']} hours shift",
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            size: 14.00,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: TextStyleInterForSplash(
                              text: "₹${controller.amount}",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              size: 14.00,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextStyleInterForSplash(
                            text: Strings.totalamount,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            size: 14.00,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: TextStyleInterForSplash(
                              text: "₹${controller.amount}",
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              size: 14.00,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap: () {
                          _showCancelShiftBottomSheet(context);
                        },
                        text: Strings.sendRequest,
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

  void _showCancelShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                SvgPicture.asset(
                  "lib/Assets/Images/sentrequest.svg",
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 5),
                Text(
                  Strings.sentRequest,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  Strings.sentrequestmsg,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE7F4FD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            Strings.no,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorPrimaryDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close bottom sheet
                            controller.bookNurse();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            Strings.yes,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
