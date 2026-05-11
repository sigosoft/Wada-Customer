import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class FadedPhonenumberField extends StatelessWidget {
  final TextEditingController? controller;
  final String? selectedCountryCode;
  final List<String>? countryCodes;
  final ValueChanged<String?>? onCountryCodeChanged;
  final VoidCallback? onTap;

  const FadedPhonenumberField({
    super.key,
    this.controller,
    this.selectedCountryCode,
    this.countryCodes,
    this.onCountryCodeChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                color: const Color(0x80F3F3F3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final List<String> _codes =
                              (countryCodes != null && countryCodes!.isNotEmpty)
                                  ? countryCodes!.toSet().toList()
                                  : ['+91', '+1', '+44', '+61', '1'];

                          // If selectedCountryCode is not in the list, add it to avoid 'value not found' crash
                          if (selectedCountryCode != null &&
                              selectedCountryCode!.isNotEmpty &&
                              !_codes.contains(selectedCountryCode)) {
                            _codes.insert(0, selectedCountryCode!);
                          }

                          return DropdownButtonFormField<String>(
                            value:
                                _codes.contains(selectedCountryCode)
                                    ? selectedCountryCode
                                    : null,
                            icon: SizedBox.shrink(),
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: Strings.countryCode,
                              labelStyle: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                color: greyTextColour1,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                              ),
                              filled: false,
                              fillColor: const Color(0x80F3F3F3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                            ),
                            items:
                                _codes.map((code) {
                                  return DropdownMenuItem<String>(
                                    value: code,
                                    child: Text(
                                      code,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: greyTextColour3,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: onCountryCodeChanged,
                            onTap: onTap,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x80F3F3F3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.phone,
                          maxLines: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: greyTextColour3,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            labelText: Strings.phoneNumber,
                            labelStyle: GoogleFonts.inter(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              color: greyTextColour1,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            ),
                            filled: false,
                            fillColor: const Color(0x80F3F3F3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
