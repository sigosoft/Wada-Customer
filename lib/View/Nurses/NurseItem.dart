import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/NurseBookings/NurseBookingDetails.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/BookNowButton.dart';
import '../../Widgets/Plusfour.dart';
import 'InfoTooltip.dart';

class NurseItem extends StatelessWidget {
  const NurseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0,right: 15,bottom: 15),
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
                    child: Image.asset(
                      'lib/Assets/Images/nurse.png', // Replace with your image path
                      fit: BoxFit.contain, // Ensures the image covers the container
                     // Optional: Adjust height
                    ),
                  ),
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
                        overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
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
                      "David Thomas",
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
                        Icon(Icons.location_on, size: 16, color: greyTextColour),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "Raipur, Chhattisgarh",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
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
                          "English, Hindi",
                          style: GoogleFonts.inter(fontSize: 12,color: greyTextColour,fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Plusfour(
                          data: "Tamil, Malayalam",
                          length: 4,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("lib/Assets/Images/qualification.svg"),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "Diploma in General Nursing",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
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
                            "5 Years of Experience",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
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
            itemCount: 4,
            itemBuilder: (context, index) {
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
                                    "₹600",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "₹800", // Original price with strikethrough
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: greyTextColour,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: greyTextColour,
                                    ),
                                  ),
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
                      "4 Hours",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: greyTextColour,
                          fontWeight: FontWeight.w500
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
            onTap:(){
             Get.to(NurseBookingDetails ());
            },
            text:Strings.bookNow,
          ),
        ],
      ),
    );
  }
}