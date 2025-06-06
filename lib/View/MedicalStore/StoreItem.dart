import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({super.key});

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
              Container(
                width: 100, // Optional: Adjust width
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFE4E4E7), // Background color
                  borderRadius: BorderRadius.circular(8), // Corner radius
                ),
                child: Image.asset(
                  'lib/Assets/Images/medicalstoredummy.png', // Replace with your image path
                  fit: BoxFit.fill, // Ensures the image covers the container
                 // Optional: Adjust height
                ),
              ),
              const SizedBox(width: 8),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MedEase Pharmacy",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: greyTextColour),
                        const SizedBox(width: 3),
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
                    Text(
                      "50 km",
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
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "upto 10% for premium members",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: textcolor3,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // Ensures text wraps to the next line
          ),
        ],
      ),
    );
  }
}