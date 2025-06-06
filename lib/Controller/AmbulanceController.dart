
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsCardRowWidget.dart';
import 'package:waada_customerapp/View/SuccessPages/NurseBookingsSuccess/RequestSentSuccess.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class AmbulanceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("AmbulanceController initialized");
  }

  @override
  void onClose() {
    print("AmbulanceController disposed");
    super.onClose();
  }

  void showCancelShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyleInterWithoutPadding(
                      text: "Raipur Fast Ambulance Service",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 16.00,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                        child: SvgPicture.asset("lib/Assets/Images/CloseIcon.svg"))
                  ],
                ),
                SizedBox(height: 20),
                TextStyleInterWithoutPadding(
                  text:Strings.services,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 16.00,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: HomeNurseDetailsCardRowWidget(
                            onTap: (){
                              _showCancelShiftBottomSheet(context);
                            },
                            color: premiumMembershipText,
                            date: "₹750",
                            type: "Local Raipur",
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              _showCancelShiftBottomSheet(context);
                            },
                            child: HomeNurseDetailsCardRowWidget(
                              color: premiumMembershipText,
                              date: "₹1,800",
                              type: "AC",
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }




  void _showCancelShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
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
                SizedBox(height: 15),
                SvgPicture.asset(
                  "lib/Assets/Images/confirmRequestIcon.svg",
                  width: 40,
                  height: 40,
                ),
                SizedBox(height: 5),
                Text(
                  Strings.confirm,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Strings.sentrequestmsg,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE7F4FD),
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
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(RequestSentSuccess());
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
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }


}