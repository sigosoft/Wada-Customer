import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

import '../../Resource/Colors.dart' show greyText;

class ExpansionTileSubtitleWidget extends StatelessWidget {
  final dynamic name;

  const ExpansionTileSubtitleWidget({super.key,this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 30,
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TextStyleInterWithoutPadding(
                  textAlign: TextAlign.start,
                  text: name,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  size: 13.0,
                ),
                TextStyleInterWithoutPadding(
                  textAlign: TextAlign.start,
                  text: Strings.patient,
                  color: greyText,
                  fontWeight: FontWeight.w400,
                  size: 11.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}