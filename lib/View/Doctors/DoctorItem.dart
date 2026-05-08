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

import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class DoctorItem extends StatelessWidget {
  final dynamic doctor;
  const DoctorItem({super.key, this.doctor});

  @override
  Widget build(BuildContext context) {
    String name = doctor?['name']?.toString() ?? "Doctor";
    String specialty = doctor?['specialization']?.toString() ?? "";
    String fee = doctor?['fee']?.toString() ?? "0";
    String experience = doctor?['experience']?.toString() ?? "0";
    String location = doctor?['city']?.toString() ?? "";
    String languages = doctor?['languages']?.toString() ?? "";
    String image = doctor?['image'] != null 
        ? "${ApiConfigs.IMAGE_URL}${doctor['image']}" 
        : 'lib/Assets/Images/nurse.png';

    return Container(
      margin: const EdgeInsets.only(left: 15.0,right: 15,bottom: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FA),
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
                      color: const Color(0xFFE4E4E7), // Background color
                      borderRadius: BorderRadius.circular(8), // Corner radius
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: image.startsWith('http') 
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'lib/Assets/Images/nurse.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        : Image.asset(
                            image,
                            fit: BoxFit.contain,
                          ),
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
                        " ₹$fee",
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
              const SizedBox(width: 10),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      name,
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
                            "$specialty  |",
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
                          "$experience Years",
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
                            location,
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
                        Flexible(
                          child: Text(
                            languages,
                            style: GoogleFonts.inter(fontSize: 12,color: greyTextColour,fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        // Plusfour(
                        //   data: "Tamil, Malayalam",
                        //   length: 4,
                        // )
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