import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';

class CallAssistantButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CallAssistantButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.phone, color: colorPrimary),
        label: Text(
          Strings.callAssistant,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorPrimary,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimaryWith15Opacity,
          foregroundColor: colorPrimaryWith15Opacity,
          surfaceTintColor: colorPrimaryWith15Opacity,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return colorPrimaryWith15Opacity.withOpacity(0.2); // Change to desired effect
              }
              return null; // Default behavior
            },
          ),
        ),
      ),
    );
  }
}