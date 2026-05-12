import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class TextInputWidget extends StatelessWidget {
  final String label;
  final TextInputType type;
  final double height;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const TextInputWidget({
    super.key,required this.label,required this.type,required this.height, this.onTap, this.controller, this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child:ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent),
            ),
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextStyleInterForSplash(
                  //   text: label,
                  //   color: blackTextColor,
                  //   fontWeight: FontWeight.w400,
                  //   size: 9,
                  // ),
                  TextFormField(
                    controller: controller,
                    validator: validator,
                    onTap: onTap,
                    keyboardType: type,
                    maxLines: height > 50 ? null : 1,
                    inputFormatters: [
                      if (height <= 50)
                        FilteringTextInputFormatter.singleLineFormatter,
                      LengthLimitingTextInputFormatter(height > 50 ? 500 : 30),
                    ],
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        color: blackTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
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
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}