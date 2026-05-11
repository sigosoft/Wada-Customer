
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class CheckboxWdget extends StatefulWidget {
  CheckboxWdget(
      {super.key,
      required this.content,
      required this.size,
      required this.color,
      required this.isChecked,
      this.onChanged});
  final String content;
  final double size;
  final Color color;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;
  @override
  State<CheckboxWdget> createState() => _CheckboxWdgetState();
}

class _CheckboxWdgetState extends State<CheckboxWdget> {

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Checkbox(
        value: widget.isChecked,
        onChanged: widget.onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        activeColor: widget.color,
      ),
      Expanded(
        child: Text(
          widget.content,
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: widget.size,
            color: profileText,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    ],
    );
  }
}