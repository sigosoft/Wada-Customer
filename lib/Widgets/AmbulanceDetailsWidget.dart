import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/View/Home/HomeNurseDetailsCardRowWidget.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Widgets/TwoSubmitButtonsWidget.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class AmbulanceDetailsWidget extends StatelessWidget {
  const AmbulanceDetailsWidget({
    super.key,
    required this.buttonText,
    required this.moreOptions,
    required this.onAllServicesTapped,
  });

  final dynamic buttonText;
  final dynamic moreOptions;
  final VoidCallback? onAllServicesTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFFEAF3FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'lib/Assets/Images/ambulanceDummyImage.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Repair Fast Ambulance Service",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 2,
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
                        "50 km | 24/7 Available",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: greyTextColour,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextStyleInterWithoutPadding(
                  text: "Upto 10% for premium members",
                  color: greyTextColour,
                  fontWeight: FontWeight.w500,
                  size: 12.00,
                ),
                SizedBox(),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: HomeNurseDetailsCardRowWidget(
                    date: "₹750",
                    type: "Local Raipur",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: HomeNurseDetailsCardRowWidget(
                    date: "₹1,200",
                    type: "5-10 kms",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: HomeNurseDetailsCardRowWidget(
                    date: "₹1,800",
                    type: "AC",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: HomeNurseDetailsCardRowWidget(
                    date: "₹1,800",
                    type: "ICU unit",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          moreOptions
              ? TwoSuibmitButtonsWidget(onAllServicesTapped:onAllServicesTapped!)
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SubmitButtonWidget(text: buttonText, onTap: () {  },),
              ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}