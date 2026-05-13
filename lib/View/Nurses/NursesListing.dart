import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';

import '../../Controller/NurseListingController.dart';
import '../../Resource/Colors.dart';
import 'NurseItem.dart';

class NursesListing extends StatelessWidget {
  const NursesListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(label: Strings.nurses, showCloseIcon: false),
      body: GetBuilder<NurseListingController>(
        init: NurseListingController(),
        builder:
            (controller) => Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F8FD),
                        border: Border.all(
                          color: Color(0xFFD8EBFF),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            'lib/Assets/Images/search.svg',
                            color: profileText,
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: Strings.searchnurses,
                          hintStyle: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFFEAF3FA),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                "${Get.arguments?['location'] ?? 'Location'}, ${Get.arguments?['start_date'] ?? ''} - ${Get.arguments?['end_date'] ?? ''}, ${Get.arguments?['hour_id'] == '1'
                                    ? '4 Hours'
                                    : Get.arguments?['hour_id'] == '2'
                                    ? '8 Hours'
                                    : Get.arguments?['hour_id'] == '3'
                                    ? '12 Hours'
                                    : '24 Hours'}",
                                style: GoogleFonts.inter(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: 13,
                                  color: profileText,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: SvgPicture.asset(
                              'lib/Assets/Images/pen.svg',
                              color: profileText,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: controller.isLoading
                        ? const Center(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: colorPrimary,
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        : controller.nurses.isEmpty
                            ? const Center(child: Text("No nurses found"))
                            : NotificationListener<ScrollNotification>(
                                onNotification: (ScrollNotification scrollInfo) {
                                  if (scrollInfo.metrics.pixels ==
                                          scrollInfo.metrics.maxScrollExtent &&
                                      !controller.isLoadMore) {
                                    controller.loadMoreNurses();
                                  }
                                  return false;
                                },
                                child: ListView.builder(
                                  itemCount: controller.nurses.length +
                                      (controller.isLoadMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index < controller.nurses.length) {
                                      return NurseItem(
                                        nurse: controller.nurses[index],
                                      );
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: colorPrimary,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
