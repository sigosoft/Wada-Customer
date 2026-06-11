import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';

class RelationshipDropdownField extends StatefulWidget {
  final String? value;
  final Function(String?)? onChanged;
  final List<Map<String, dynamic>> relations;
  const RelationshipDropdownField({
    super.key,
    this.value,
    this.onChanged,
    this.relations = const [],
  });

  @override
  State<RelationshipDropdownField> createState() =>
      _RelationshipDropdownFieldState();
}

class _RelationshipDropdownFieldState extends State<RelationshipDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: DropdownButtonFormField<String>(
        value: widget.value,
        items:
            widget.relations
                .map(
                  (relation) => DropdownMenuItem<String>(
                    value: relation['id'].toString(),
                    child: Text(
                      relation['relationship'].toString(),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
        onChanged: widget.onChanged,

        decoration: InputDecoration(
          labelText: Strings.relationshipwithstar,
          labelStyle: GoogleFonts.inter(
            fontSize: 12,
            color: blackTextColor,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9),
            ),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 20,
            ),
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
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        isDense: true,
        icon: null,
        iconSize: 0, // Hides the default dropdown arrow
      ),
    );
  }
}
