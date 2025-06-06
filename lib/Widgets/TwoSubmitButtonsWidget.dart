import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart' show Strings;

class TwoSuibmitButtonsWidget extends StatelessWidget {
  final VoidCallback onAllServicesTapped;

  const TwoSuibmitButtonsWidget({super.key,required this.onAllServicesTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: onAllServicesTapped,
                style: ElevatedButton.styleFrom(
                  backgroundColor: premiumMembershipText,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: colorPrimary, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  Strings.allServices,
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  Strings.bookNow,
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
    );
  }
}
