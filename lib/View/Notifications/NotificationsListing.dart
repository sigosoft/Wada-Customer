import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/NotificationsController.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/CustomAppBar.dart';
import 'NotificationItem.dart';

class NotificationsListing extends StatefulWidget {
  @override
  State<NotificationsListing> createState() => _NotificationsListingState();
}

class _NotificationsListingState extends State<NotificationsListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(label: Strings.notifications, showCloseIcon: false),
      body: GetBuilder<NotificationsController>(
        init: NotificationsController(),
        initState: (_) {},
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 15),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/Assets/Images/No data.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "No notifications",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // child:  Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20,bottom: 5),
            //       child: Text("Today",
            //           style: GoogleFonts.inter(
            //               fontSize: 18,
            //               fontWeight: FontWeight.w700,
            //               color: Colors.black)),
            //     ),
            //     ListView.builder(
            //       itemCount: 5,
            //       shrinkWrap: true,
            //       physics: AlwaysScrollableScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         return NotificationItem(
            //         );
            //       },
            //     ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
