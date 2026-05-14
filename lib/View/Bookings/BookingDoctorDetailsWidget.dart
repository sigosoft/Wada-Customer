import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsCardRowWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Widgets/Plusfour.dart';
import 'package:waada_customerapp/Configs/ApiConfigs.dart';

class BookingsDoctorDetailsWidget extends StatelessWidget {
  final dynamic showButton;
  final dynamic buttonText;
  final dynamic padding;
  final Map<String, dynamic>? doctorData;
  final Map<String, dynamic>? bookingData;

  const BookingsDoctorDetailsWidget({
    super.key,
    required this.showButton,
    required this.buttonText,
    this.padding,
    this.doctorData,
    this.bookingData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 15),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEAF3FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Corner radius
                        ),
                        child:
                            (doctorData?['image'] != null &&
                                    doctorData!['image'].toString().isNotEmpty)
                                ? Image.network(
                                  "${ApiConfigs.IMAGE_URL}${doctorData!['image']}",
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (_, __, ___) => Image.asset(
                                        'lib/Assets/Images/doctorProfileImage.png',
                                        fit: BoxFit.contain,
                                      ),
                                )
                                : Image.asset(
                                  'lib/Assets/Images/doctorProfileImage.png',
                                  fit: BoxFit.contain,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Details Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorData?['name'] ?? "Doctor Name",
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
                                "${doctorData?['qualification'] ?? "Qualification"}  |",
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
                              "${doctorData?['experience'] ?? 0} Years",
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
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: greyTextColour,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                doctorData?['location'] ?? "Location",
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
                              (doctorData?['languages'] as List?)?.isNotEmpty ==
                                      true
                                  ? (doctorData!['languages'] as List)
                                      .take(2)
                                      .map((l) => l['language'] ?? l)
                                      .join(", ")
                                  : "Languages",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: greyTextColour,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if ((doctorData?['languages'] as List?) != null &&
                                (doctorData!['languages'] as List).length > 2)
                              Plusfour(
                                data: (doctorData!['languages'] as List)
                                    .skip(2)
                                    .map((l) => l['language'] ?? l)
                                    .join(", "),
                                length:
                                    (doctorData!['languages'] as List).length -
                                    2,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: HomeNurseDetailsCardRowWidget(
                      date: bookingData?['date'] ?? "N/A",
                      type: Strings.date,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: HomeNurseDetailsCardRowWidget(
                      date:
                          bookingData?['time'] ??
                          ((bookingData?['start_time'] != null &&
                                  bookingData?['end_time'] != null)
                              ? "${bookingData?['start_time']} - ${bookingData?['end_time']}"
                              : "N/A"),
                      type: Strings.time,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: HomeNurseDetailsCardRowWidget(
                      date: bookingData?['patient'] ?? "Patient Name",
                      type: Strings.patient,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: HomeNurseDetailsCardRowWidget(
                      date: bookingData?['consult_type'] ?? "Consult Type",
                      type: Strings.consultType,
                    ),
                  ),
                ],
              ),
              SizedBox(height: showButton ? 15 : 5),
              showButton
                  ? SubmitButtonWidget(
                    image:
                        buttonText == "Join"
                            ? "lib/Assets/Images/videocall.svg"
                            : null,
                    text: buttonText,
                    onTap: () {},
                  )
                  : Container(),
              SizedBox(height: showButton ? 10 : 0),
            ],
          ),
        ),
      ),
    );
  }
}
