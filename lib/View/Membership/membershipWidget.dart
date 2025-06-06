import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Resource/Colors.dart';

class MemberShipCard extends StatelessWidget {
  final dynamic icon;
  final dynamic membershipName;
  final dynamic membershipDescription;

  const MemberShipCard({
    super.key,
    this.icon,
    this.membershipName,
    this.membershipDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        elevation: 5,
        child: Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // stops: [0.7, 1.0],
              colors: [premiumMembershipGradient1, premiumMembershipGradient2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleInterWithoutPadding(
                    text: membershipName,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.045,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text(
                      membershipDescription,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}