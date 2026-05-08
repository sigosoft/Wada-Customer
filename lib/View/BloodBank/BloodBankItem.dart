import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';

class BloodBankItem extends StatelessWidget {
  final dynamic donor;
  const BloodBankItem({super.key, this.donor});

  String _getBloodGroup(dynamic id) {
    switch (id.toString()) {
      case "1": return "A+ve";
      case "2": return "A-ve";
      case "3": return "B+ve";
      case "4": return "B-ve";
      case "5": return "O+ve";
      case "6": return "O-ve";
      case "7": return "AB+ve";
      case "8": return "AB-ve";
      default: return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = donor?['donor_name']?.toString() ?? "Donor";
    String location = donor?['location']?.toString() ?? "";
    String gender = (donor?['gender']?.toString() == "1") ? "Male" : "Female";
    String bloodGroup = _getBloodGroup(donor?['blood_group_id']);

    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image and Availability
              Container(
                width: 50, // Optional: Adjust width
                height: 50,
                child: Image.asset(
                  'lib/Assets/Images/profile.png',
                  fit: BoxFit.contain,
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
                      name,
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
                            location,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      gender,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: greyTextColour,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                    color: const Color(0xFFCF3535), // Background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Center(
                    child: Text(
                      bloodGroup,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
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
                        const Icon(
                          Icons.phone, // Phone icon
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                    icon: const SizedBox.shrink(),
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
