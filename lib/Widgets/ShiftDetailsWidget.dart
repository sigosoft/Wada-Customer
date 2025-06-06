import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';
import '../Resource/Strings.dart';

class ShiftDetailsWidget extends StatefulWidget {
  final String text1;
  final String text2;
  final bool showInfoButton;

  const ShiftDetailsWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.showInfoButton = true,
  });

  @override
  State<ShiftDetailsWidget> createState() => _ShiftDetailsWidgetState();
}

class _ShiftDetailsWidgetState extends State<ShiftDetailsWidget> {

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 20,top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  Strings.dummy,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: greyTextColour,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.text1,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.text2,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: greyTextColour,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (widget.showInfoButton)
            InkWell(
              onTap: () => showCustomDialog(context),
              child: Center(
                child: Icon(Icons.info_outlined, size: 18, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}