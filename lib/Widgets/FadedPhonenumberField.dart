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
  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? countryValidator;

  const FadedPhonenumberField({
    super.key,
    this.controller,
    this.selectedCountryCode,
    this.countryCodes,
    this.onCountryCodeChanged,
    this.onTap,
    this.phoneValidator,
    this.countryValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                color: const Color(0x80F3F3F3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
              ),
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Builder(
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
                          validator: countryValidator,
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
                            errorStyle: const TextStyle(height: 0, fontSize: 0),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
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
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller,
                        validator: phoneValidator,
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
                            textStyle: Theme.of(context).textTheme.displayLarge,
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
                          errorStyle: const TextStyle(height: 0, fontSize: 0),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
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
