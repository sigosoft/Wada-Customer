import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';
import '../Resource/Strings.dart';
import '../View/Nurses/InfoTooltip.dart';

class ShiftTypeWidget extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const ShiftTypeWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<ShiftTypeWidget> createState() => _ShiftTypeWidgetState();
}

class _ShiftTypeWidgetState extends State<ShiftTypeWidget> {
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              bottom: 20,
              top: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.close, color: Colors.black, size: 25),
                  ),
                ),
                SizedBox(height: 5),
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
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? colorPrimary : Color(0xFFEAF3FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: widget.isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            InfoTooltip(),
          ],
        ),
      ),
    );
  }
}
