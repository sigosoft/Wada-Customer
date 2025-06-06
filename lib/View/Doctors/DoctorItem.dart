import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/DoctorBookings/RequestHomeVisit.dart';
import 'package:waada_customerapp/View/DoctorBookings/VideoConsult.dart';
import 'package:waada_customerapp/View/Doctors/BookingTypeWidget.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/Plusfour.dart';
import '../../Widgets/ShiftDetailsWidget.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({super.key});

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
                    width: 85, // Optional: Adjust width
                    height: 75,
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
                        Strings.fee,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: greyTextColour,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
                      ),
                      Text(
                        "₹500",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
                      ),
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
                    const SizedBox(height: 2),
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
          Row(children: [
              Expanded(child: InkWell(
                onTap: () {
                  Get.to(RequestHomeVisit());
                },
                  child: BookingTypeWidget(text1: Strings.requesthomevisit,image:"lib/Assets/Images/homevisit.svg"))),
              SizedBox(width: 10,),
              Expanded(child: InkWell(
                onTap: (){
                  Get.to(VideoConsult());
                },
                  child: BookingTypeWidget(text1: Strings.videoconsult,image: "lib/Assets/Images/videocall.svg"))),
            ],),
        ],
      ),
    );
  }
}