import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widgets/Plusfour.dart';

class NurseDetailsWidget extends StatelessWidget {
  const NurseDetailsWidget({
    super.key,
    required this.showPartiallyAvailable,
    this.nurseData,
  });
  final bool showPartiallyAvailable;
  final Map<String, dynamic>? nurseData;

  @override
  Widget build(BuildContext context) {
    String name =
        nurseData?['name']?.toString() ??
        nurseData?['user']?['name']?.toString() ??
        "Nurse Name";
    String location =
        nurseData?['location']?.toString() ??
        nurseData?['user']?['location']?.toString() ??
        "Location";
    String qualification =
        nurseData?['qualification']?.toString() ??
        nurseData?['user']?['qualification']?.toString() ??
        "Qualification";
    String experience =
        "${nurseData?['experience'] ?? nurseData?['user']?['experience'] ?? '0'} Years of Experience";

    String? rawImage =
        nurseData?['image']?.toString() ??
        nurseData?['user']?['image']?.toString() ??
        nurseData?['profile_pic']?.toString() ??
        nurseData?['user']?['profile_pic']?.toString() ??
        nurseData?['profile_image']?.toString() ??
        nurseData?['user']?['profile_image']?.toString();

    String image =
        (rawImage != null && rawImage.isNotEmpty)
            ? rawImage.startsWith('http')
                ? rawImage
                : "${ApiConfigs.IMAGE_URL}$rawImage"
            : "";

    // Languages logic
    List<dynamic> languagesList =
        nurseData?['languages'] ??
        nurseData?['user']?['languages'] ??
        nurseData?['nurse_languages'] ??
        nurseData?['user']?['nurse_languages'] ??
        [];
    String languageString =
        languagesList.isNotEmpty
            ? languagesList.take(2).map((e) => e['language']).join(", ")
            : "Languages";
    String extraLanguages =
        languagesList.length > 2
            ? languagesList.skip(2).map((e) => e['language']).join(", ")
            : "";
    int totalLanguages = languagesList.length;

    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
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
                    width: 110,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4E4E7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        image.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 48,
                                            color: Color(0xFFAAAAAA),
                                          ),
                                        ),
                              ),
                            )
                            : const Center(
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: Color(0xFFAAAAAA),
                              ),
                            ),
                  ),
                  const SizedBox(height: 3),
                  showPartiallyAvailable
                      ? Row(
                        children: [
                          Text(
                            Strings.partiallyavailable,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.info_outlined,
                            size: 18,
                            color: Colors.black,
                          ),
                        ],
                      )
                      : Container(),
                ],
              ),
              const SizedBox(width: 10),
              // Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showPartiallyAvailable
                        ? const SizedBox(height: 5)
                        : Container(),
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
                          languageString,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: greyTextColour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (totalLanguages > 2) ...[
                          const SizedBox(width: 8),
                          Plusfour(
                            data: extraLanguages,
                            length: totalLanguages,
                          ),
                        ],
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
