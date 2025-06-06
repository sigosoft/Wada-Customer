
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';

import '../../Widgets/NurseBookingDetailsWidget.dart';
import '../Bookings/BookingDoctorDetailsWidget.dart';

class WalletItem extends StatelessWidget {

  const WalletItem({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (type.toString() == "Credit") {
          showCreditDetailsBottomSheet(context);
        } else {
          showDebitDetailsBottomSheet(context);
        }
      },
      child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: borderLine,
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text('24 Oct 2023',
                      style: GoogleFonts.inter(
                        color: profileText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                  Row(
                      children: [
                        Expanded(child:
                        Text('Wada Office',
                            style: GoogleFonts.inter(
                              color: profileText,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),),

                       type.toString()=="Credit"?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "lib/Assets/Images/credit.svg",
                                  width: 15,
                                  height: 15,
                                ),
                                SizedBox(width: 5,),
                                Text(Strings.credit,
                                    style: GoogleFonts.inter(
                                      color: profileText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            Text('+100',
                                style: GoogleFonts.inter(
                                  color: green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ):
                       Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Row(
                             children: [
                               SvgPicture.asset(
                                 "lib/Assets/Images/debit.svg",
                                 width: 15,
                                 height: 15,
                               ),
                               SizedBox(width: 5,),
                               Text(Strings.debit,
                                   style: GoogleFonts.inter(
                                     color: profileText,
                                     fontSize: 12,
                                     fontWeight: FontWeight.w400,
                                   )),
                             ],
                           ),
                           Text('-100',
                               style: GoogleFonts.inter(
                                 color: red1,
                                 fontSize: 14,
                                 fontWeight: FontWeight.w600,
                               )),
                         ],
                       )

                      ]),
                  Text('Referral',
                      style: GoogleFonts.inter(
                        color: profileText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),

                ],
              ),
            ),
          )),
    );
  }

  void showCreditDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "lib/Assets/Images/walletcredit.svg",
                    width: 45,
                    height: 45,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wada Office",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: profileText,
                    ),
                  ),
                  Text(
                    "+100",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Doctor Booking Cancelled | 24 Oct 2023",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: profileText,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Booking Details",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: profileText,
                ),
              ),
              SizedBox(height: 10),
              BookingsDoctorDetailsWidget(showButton: false,buttonText: false,padding:0.0)
            ],
          ),
        );
      },
    );
  }

  void showDebitDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "lib/Assets/Images/walletdebit.svg",
                    width: 45,
                    height: 45,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "David Thomas",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: profileText,
                    ),
                  ),
                  Text(
                    "-100",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: red1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Nurse Booking | 24 Oct 2023",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: profileText,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Booking Details",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: profileText,
                ),
              ),
              SizedBox(height: 10),
              NurseBookingDetailsWidget()
            ],
          ),
        );
      },
    );
  }
}
