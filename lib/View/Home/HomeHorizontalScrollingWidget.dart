import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class HomeHorizontalScrollingWidget extends StatelessWidget {
  final dynamic homeRowWidgetItems;
  final dynamic screenList;

  const HomeHorizontalScrollingWidget({
    super.key,
    this.homeRowWidgetItems,
    this.screenList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: homeRowWidgetItems.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (screenList != null && screenList.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screenList[index]),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: 130,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    homeRowWidgetItems[index]['icon'].toString().startsWith(
                          'http',
                        )
                        ? Image.network(
                          homeRowWidgetItems[index]['icon'].toString(),
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (_, __, ___) => SvgPicture.asset(
                                "lib/Assets/Images/HomeScreenRowIcon1.svg",
                                width: 40,
                                height: 40,
                              ),
                        )
                        : SvgPicture.asset(
                          homeRowWidgetItems[index]['icon'].toString(),
                          fit: BoxFit.scaleDown,
                        ),
                    SizedBox(height: 10),
                    TextStyleInterWithoutPadding(
                      text: homeRowWidgetItems[index]['name'].toString(),
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      size: 14.00,
                    ),
                    SizedBox(height: 10),
                    TextStyleInterWithoutPadding(
                      maxLines: 3,
                      text: homeRowWidgetItems[index]['description'].toString(),
                      color: greyText,
                      fontWeight: FontWeight.w400,
                      size: 12.00,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
