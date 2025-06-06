import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';

class BloodBankItem extends StatelessWidget {
  const BloodBankItem({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image and Availability
              Container(
                width: 50, // Optional: Adjust width
                height: 50,
                // decoration: BoxDecoration(
                //   color: Color(0xFFE4E4E7), // Background color
                //   borderRadius: BorderRadius.circular(8), // Corner radius
                // ),
                child: Image.asset(
                  'lib/Assets/Images/profile.png',
                  // Replace with your image path
                  fit: BoxFit.contain, // Ensures the image covers the container
                  // Optional: Adjust height
                ),
              ),
              const SizedBox(width: 8),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "John Jacob",
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
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: greyTextColour,
                        ),
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
                            overflow:
                                TextOverflow
                                    .ellipsis, // Ensures text wraps to the next line
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Male",
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFCF3535), // Background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Center(
                    child: Text(
                      "A+ve",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary, // Use the primary color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded edges
                      ),
                    ),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.callnow, // "Call Now" string
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // Text color
                          ),
                        ),
                        const SizedBox(width: 5),
                        // Add spacing between text and icon
                        Icon(
                          Icons.phone, // Phone icon
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                    icon:
                        const SizedBox.shrink(), // Empty icon to satisfy ElevatedButton.icon
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
