import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';

class DateSlotSelector extends StatefulWidget {
  const DateSlotSelector({Key? key}) : super(key: key);

  @override
  State<DateSlotSelector> createState() => _DateSlotSelectorState();
}

class _DateSlotSelectorState extends State<DateSlotSelector> {
  int selectedDateIndex = 0;
  int selectedSlotIndex = -1;

  final List<Map<String, String>> dates = [
    {"day": "Sun", "date": "Today"},
    {"day": "Monday", "date": "Tomorrow"},
    {"day": "Tue", "date": "23"},
    {"day": "Wed", "date": "24"},
    {"day": "Thu", "date": "25"},
  ];

  final List<String> slots = [
    "09:00 AM - 09:30 AM",
    "09:00 AM - 09:30 AM",
    "09:00 AM - 09:30 AM",
    "09:00 AM - 09:30 AM",
    "09:00 AM - 09:30 AM",
    "09:00 AM - 09:30 AM",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10), // Padding from left and right
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF3FA),
          borderRadius: BorderRadius.circular(15), // Rounded edges
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Container
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Feb",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            // Horizontal Date ListView
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                    child: Row(children: [Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected ? colorPrimary : Colors.transparent,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(
                            children: [
                              Text(
                                dates[index]["date"]!,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dates[index]["day"]!,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? Colors.white : greyTextColour,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                      (index==selectedDateIndex-1||index==selectedDateIndex||index==dates.length-1)?Container():
                      Container(color: Colors.grey,
                        width: 1,
                        height: 20,),]),
                  );
                },
              ),
            ),

            // Slots GridView
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text(
                    "5 Slots Available",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color:greyTextColour,
                    ),
                  ),
                  SizedBox(height: 10,),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedSlotIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSlotIndex = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? colorPrimary : Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: isSelected ? colorPrimary : borderLine1,
                            ),
                          ),
                          child: Text(
                            slots[index],
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}