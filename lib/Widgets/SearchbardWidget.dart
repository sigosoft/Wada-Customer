import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:waada_customerapp/Resource/Colors.dart';

class SearchBarWidget extends StatelessWidget {
  final dynamic labelText;

  const SearchBarWidget({super.key, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF3F8FD),
          // border: Border.all(color: Color(0xFFD8EBFF), width: 1.0),
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
            hintText: labelText,
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
    );
  }
}
