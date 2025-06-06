import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';


class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: _obscureText,
        style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ),
        decoration: InputDecoration(
          labelText: Strings.password,
          labelStyle: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 9,
            color: blackTextColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: SvgPicture.asset(
              _obscureText
                  ? "lib/Assets/Images/passwordEye.svg"
                  : "lib/Assets/Images/passwordEye.svg",
              // You may want to use a different icon for visible
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
