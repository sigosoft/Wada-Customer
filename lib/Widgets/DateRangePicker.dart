import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../Resource/Strings.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../View/Login/SubmitButtonWidget.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  final TextEditingController _dateController = TextEditingController();
  String _range =
      '${DateFormat('MMM d').format(DateTime.now())} -'
      // ignore: lines_longer_than_80_chars
      ' ${DateFormat('MMM d').format(DateTime.now())}';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (stfContext, stfSetState) {
            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [colorPrimary, colorPrimary],
                  ),
                ),
                width: double.infinity,
                height: 130,
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: EdgeInsets.only(right: 20,bottom: 20), // Remove default padding
                      ),
                       Text(
                        "SELECTED RANGE",
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _range,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              content: SizedBox(
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: SfDateRangePicker(
                        enablePastDates: false,
                        onSelectionChanged: (
                          DateRangePickerSelectionChangedArgs args,
                        ) {
                          stfSetState(() {
                            if (args.value is PickerDateRange) {
                              _range =
                                  '${DateFormat('MMM d').format(args.value.startDate)} -'
                                  // ignore: lines_longer_than_80_chars
                                  ' ${DateFormat('MMM d').format(args.value.endDate ?? args.value.startDate)}';
                              startDate = args.value.startDate;
                              endDate =
                                  args.value.endDate ?? args.value.startDate;
                            }
                          });
                        },
                        selectionMode: DateRangePickerSelectionMode.range,
                        navigationDirection: DateRangePickerNavigationDirection.vertical,
                        showNavigationArrow: false,
                        navigationMode: DateRangePickerNavigationMode.scroll,
                        viewSpacing: 10,
                        initialSelectedRange: PickerDateRange(
                          DateTime.now(),
                          DateTime.now(),
                        ),
                        startRangeSelectionColor: colorPrimary,
                        endRangeSelectionColor: colorPrimary,
                        rangeSelectionColor: colorPrimary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.only(
                left: 5.0,
                right: 5.0,
                bottom: 0,
                top: 10,
              ),
              actions: [
                InkWell(
                  onTap:(){
                    _dateController.text =
                    "${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}";
                    // toDateController.text =
                    //     DateFormat('dd MMM yyyy').format(endDate);
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child:  TextStyleInterForSplash(
                      text: Strings.select,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      size: 16.00,
                    ),
                  ),
                )

              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => _showCustomDialog(context),
        child: AbsorbPointer(
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    labelText: Strings.date,
                    labelStyle: GoogleFonts.inter(
                      fontSize: 13,
                      color: blackTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Icon(Icons.calendar_today, color: Colors.black),
                    ),
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
