import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';

class MemberDropdownField extends StatelessWidget {
  final List<dynamic>? members;
  final dynamic selectedMemberId;
  final Function(dynamic)? onChanged;

  const MemberDropdownField({
    super.key,
    this.members,
    this.selectedMemberId,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic> displayMembers =
        members ??
        [
          {'id': 'Merlin Joy', 'name': 'Merlin Joy'},
          {'id': 'Joy', 'name': 'Joy'},
          {'id': 'Cristina', 'name': 'Cristina'},
        ];

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: DropdownButtonFormField<dynamic>(
        value: selectedMemberId ?? (members == null ? 'Merlin Joy' : null),
        items:
            displayMembers.map((member) {
              return DropdownMenuItem<dynamic>(
                value: member['id'],
                child: Text(
                  member['name'] ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
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
