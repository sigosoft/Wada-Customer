import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/Plusfour.dart';

class NurseDetailsWidget extends StatelessWidget {
  const NurseDetailsWidget({super.key,required this.showPartiallyAvailable});
  final bool showPartiallyAvailable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0,right: 15,),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  showPartiallyAvailable?
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
                  ):Container(),
                ],
              ),
              const SizedBox(width: 5),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showPartiallyAvailable?
                    const SizedBox(height: 5):Container(),
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
        ],
      ),
    );
  }
}