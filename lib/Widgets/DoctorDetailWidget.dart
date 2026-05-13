import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';
import '../../Widgets/Plusfour.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class DoctorDetailWidget extends StatelessWidget {
  final dynamic doctorData;
  const DoctorDetailWidget({super.key, this.doctorData});

  @override
  Widget build(BuildContext context) {
    String name = doctorData?['name']?.toString() ?? "Doctor";

    // Extract specializations
    List specs = doctorData?['specializations'] ?? [];
    String specialty = specs.map((e) => e['specialization']).join(", ");
    if (specialty.isEmpty) specialty = doctorData?['specialization']?.toString() ?? "";

    String experience = doctorData?['experience']?.toString() ?? "0";
    String location = doctorData?['location']?.toString() ?? doctorData?['city']?.toString() ?? "";

    // Extract languages
    List langs = doctorData?['languages'] ?? [];
    String languages = langs.map((e) => e['language']).join(", ");
    if (languages.isEmpty) {
      languages = doctorData?['languages_string']?.toString() ?? "";
    }

    // Extract image
    String? imgPath = doctorData?['image']?.toString();
    if (imgPath == null && specs.isNotEmpty) {
      imgPath = specs[0]['image']?.toString();
    }

    String image =
        imgPath != null
            ? "${ApiConfigs.IMAGE_URL}$imgPath"
            : 'lib/Assets/Images/nurse.png';

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 95,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4E4E7),
                      borderRadius: BorderRadius.circular(8),
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
                          : Image.asset(image, fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
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
                        Flexible(
                          child: Text(
                            "$specialty  |",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: greyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(
                          "lib/Assets/Images/years.svg",
                          height: 13,
                          width: 13,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$experience Years",
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
                        Flexible(
                          child: Text(
                            languages,
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