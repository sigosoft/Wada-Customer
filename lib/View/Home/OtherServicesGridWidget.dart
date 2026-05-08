import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class OtherServicesGrid extends StatelessWidget {
  final dynamic otherServicesList;
  final dynamic onTap;

  const OtherServicesGrid({super.key, this.otherServicesList, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: otherServicesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: otherServicesList[index]['route'] != null
                ? () => otherServicesList[index]['route']()
                : onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFEAF3FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: otherServicesList[index]['icon'].toString().startsWith('http')
                        ? Image.network(
                            otherServicesList[index]['icon'].toString(),
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => SvgPicture.asset(
                              "lib/Assets/Images/OtherServicesIcon1.svg",
                              height: 30,
                              width: 30,
                            ),
                          )
                        : SvgPicture.asset(
                            otherServicesList[index]['icon'].toString(),
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                  ),
               SizedBox(height: 5,),
               Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextStyleInterWithoutPadding(
                        maxLines: 2,
                        text: otherServicesList[index]['name'].toString(),
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 12.00,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}