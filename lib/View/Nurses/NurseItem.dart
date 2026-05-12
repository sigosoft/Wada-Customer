import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import 'package:waada_customerapp/View/NurseBookings/NurseBookingDetails.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/BookNowButton.dart';
import '../../Widgets/Plusfour.dart';
import 'InfoTooltip.dart';

class NurseItem extends StatelessWidget {
  final Map<String, dynamic> nurse;
  const NurseItem({super.key, required this.nurse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Upper Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image and Availability
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 110, // Optional: Adjust width
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E4E7), // Background color
                      borderRadius: BorderRadius.circular(8), // Corner radius
                    ),
                    child:
                        (nurse['image'] != null &&
                                nurse['image'].toString().isNotEmpty)
                            ? Image.network(
                              "${ApiConfigs.IMAGE_URL}${nurse['image']}",
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                    'lib/Assets/Images/nurse.png',
                                    fit: BoxFit.contain,
                                  ),
                            )
                            : Image.asset(
                              'lib/Assets/Images/nurse.png',
                              fit: BoxFit.contain,
                            ),
                  ),
                  //),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        Strings.partiallyavailable,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow:
                            TextOverflow
                                .ellipsis, // Ensures text wraps to the next line
                      ),
                      const SizedBox(width: 5),
                      Icon(Icons.info_outlined, size: 18, color: Colors.black),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 5),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      nurse['name']?.toString() ?? "Nurse Name",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: greyTextColour,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            nurse['location']?.toString() ?? "Location",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis, // Ensures text wraps to the next line
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("lib/Assets/Images/language.svg"),
                        const SizedBox(width: 5),
                        Text(
                          (nurse['nurse_languages'] as List?)
                                  ?.map((l) => l['language'])
                                  .join(", ") ??
                              "Languages",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: greyTextColour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if ((nurse['nurse_languages'] as List?) != null &&
                            (nurse['nurse_languages'] as List).length > 2)
                          Plusfour(
                            data: (nurse['nurse_languages'] as List)
                                .skip(2)
                                .map((l) => l['language'])
                                .join(", "),
                            length: (nurse['nurse_languages'] as List).length,
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("lib/Assets/Images/qualification.svg"),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            nurse['qualification']?.toString() ??
                                "Qualification",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis, // Ensures text wraps to the next line
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("lib/Assets/Images/experience.svg"),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "${nurse['experience'] ?? 0} Years of Experience",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis, // Ensures text wraps to the next line
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Bottom Section
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: (nurse['nurse_charges'] as List?)?.length ?? 0,
            itemBuilder: (context, index) {
              final charge = (nurse['nurse_charges'] as List)[index];
              String hourText = "4 Hours";
              if (charge['hour_id'].toString() == "1") hourText = "4 Hours";
              if (charge['hour_id'].toString() == "2") hourText = "8 Hours";
              if (charge['hour_id'].toString() == "3") hourText = "12 Hours";
              if (charge['hour_id'].toString() == "4") hourText = "24 Hours";
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹${charge['price']}",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // SizedBox(width: 5,),
                                  // Text(
                                  //   "₹800", // Original price with strikethrough
                                  //   style: GoogleFonts.inter(
                                  //     fontSize: 12,
                                  //     color: greyTextColour,
                                  //     decoration: TextDecoration.lineThrough,
                                  //     decorationColor: greyTextColour,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InfoTooltip(),
                      ],
                    ),

                    const SizedBox(height: 3),
                    Text(
                      hourText,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: greyTextColour,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Get it at ₹400 for premium members!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: colorPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 15),
          // Book Now Button
          BookNowButton(
            onTap: () {
              Get.to(
                const NurseBookingDetails(),
                arguments: {
                  'nurse_id': nurse['id'] ?? nurse['nurse_id'],
                  'start_date': Get.arguments?['start_date'],
                  'end_date': Get.arguments?['end_date'],
                  'hour_id': Get.arguments?['hour_id'],
                },
              );
            },
            text: Strings.bookNow,
          ),
        ],
      ),
    );
  }
}
