import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsCardRowWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/NurseBookings/ShareLocationBookingDetails.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/Plusfour.dart';

class HomeNurseDetailsWidget extends StatelessWidget {
  const HomeNurseDetailsWidget({
    super.key,
    required this.showButton,
    required this.buttonText,
    this.onTapButton,
    this.name = "David Thomas",
    this.location = "Raipur, Chhattisgarh",
    this.languages = "English, Hindi",
    this.qualification = "Diploma in General Nursing",
    this.experience = "5 Years of Experience",
    this.imagePath = 'lib/Assets/Images/nurse.png',
    this.checkInDate = "08 Feb 2025",
    this.checkInTime = "09:30 AM",
    this.plusLanguages = "Tamil, Malayalam",
  });

  final bool showButton;
  final dynamic buttonText;
  final dynamic onTapButton;
  final String name;
  final String location;
  final String languages;
  final String qualification;
  final String experience;
  final String imagePath;
  final String checkInDate;
  final String checkInTime;
  final String plusLanguages;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image and Availability
                Container(
                  width: 110,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4E4E7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imagePath.startsWith('http')
                        ? Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'lib/Assets/Images/nurse.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        : Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                // Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Row(
                        children: [
                          SvgPicture.asset("lib/Assets/Images/language.svg"),
                          const SizedBox(width: 5),
                          Text(
                            languages,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (plusLanguages.isNotEmpty)
                            Plusfour(data: plusLanguages, length: 4),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SvgPicture.asset("lib/Assets/Images/qualification.svg"),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              qualification,
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
                      Row(
                        children: [
                          SvgPicture.asset("lib/Assets/Images/experience.svg"),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              experience,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: HomeNurseDetailsCardRowWidget(
                    date: checkInDate,
                    type: Strings.checkInDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: HomeNurseDetailsCardRowWidget(
                    date: checkInTime,
                    type: Strings.checkInTime,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: showButton ? 15 : 5),
          showButton
              ? InkWell(
                  onTap: onTapButton,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SubmitButtonWidget(
                      text: buttonText,
                      onTap: () {},
                    ),
                  ))
              : Container(),
          SizedBox(height: showButton ? 10 : 0),
        ],
      ),
    );
  }
}


