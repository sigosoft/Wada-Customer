import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/Plusfour.dart';

class DoctorDetailWidget extends StatelessWidget {
  const DoctorDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
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
                    width: 100, // Optional: Adjust width
                    height: 95,
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
                ],
              ),
              const SizedBox(width: 5),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Ahmed Khan",
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
                        Flexible(
                          child: Text(
                            "Cardiologist  |",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset("lib/Assets/Images/years.svg",height: 13,width: 13,),
                        const SizedBox(width: 5),
                        Text(
                          "2 Years",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: greyTextColour,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
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