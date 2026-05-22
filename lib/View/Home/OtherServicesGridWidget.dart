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
            onTap: () {
              final String name = otherServicesList[index]['name']?.toString().toLowerCase() ?? '';
              if (name.contains('blood')) {
                if (otherServicesList[index]['route'] != null) {
                  otherServicesList[index]['route']();
                } else if (onTap != null) {
                  onTap();
                }
              } else {
                showComingSoonDialog(context);
              }
            },
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
                    child:
                        otherServicesList[index]['icon'].toString().startsWith(
                              'http',
                            )
                            ? Image.network(
                              otherServicesList[index]['icon'].toString(),
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (_, __, ___) => const Icon(
                                    Icons.image_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                            )
                            : (otherServicesList[index]['icon']
                                    .toString()
                                    .isNotEmpty
                                ? SvgPicture.asset(
                                  otherServicesList[index]['icon'].toString(),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                )
                                : const Icon(
                                  Icons.image_outlined,
                                  size: 30,
                                  color: Colors.white,
                                )),
                  ),
                  SizedBox(height: 5),
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
