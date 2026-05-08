import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';

class AgreeWithTermsWidget extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  const AgreeWithTermsWidget({super.key, this.onChanged});

  @override
  State<AgreeWithTermsWidget> createState() => _AgreeWithTermsWidgetState();
}

class _AgreeWithTermsWidgetState extends State<AgreeWithTermsWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Rounded corners
          ),
          activeColor: colorPrimary, // Primary color for the checkbox
        ),
        const SizedBox(width: 0),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: Strings.agreeWith,
              style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 12,
                color: greyTextColour,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              children: [
                TextSpan(
                  text: Strings.termsAndConditions,
                  style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 12,
            color: colorPrimary,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
                    decoration: TextDecoration.underline,
                      decorationColor: colorPrimary
          ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Terms & Conditions click
                    },
                ),
                 TextSpan(
                  text: Strings.and,
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 12,
                    color: greyTextColour,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: Strings.privacyPolicy,
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 12,
                      color: colorPrimary,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.underline,
                    decorationColor: colorPrimary
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Privacy Policy click
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}