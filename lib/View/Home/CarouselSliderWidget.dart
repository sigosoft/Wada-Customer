import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../Resource/Colors.dart' show colorPrimary, colorPrimaryWith25Opacity;

class CarouselSliderWidget extends StatelessWidget {
  final List<String> imageUrls;
  final int currentIndex;
  final Function(int) onPageChanged;

  const CarouselSliderWidget({
    Key? key,
    required this.imageUrls,
    required this.currentIndex,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150,
              // autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                onPageChanged(index);
              },
            ),
            items: imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: url.startsWith('http')
                        ? Image.network(
                            url,
                            fit: BoxFit.fill,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          )
                        : (url.isNotEmpty
                            ? Image.asset(url, fit: BoxFit.fill)
                            : const SizedBox.shrink()),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageUrls.asMap().entries.map((entry) {
            final bool isSelected = currentIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? 16.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                color: isSelected ? colorPrimary : colorPrimaryWith25Opacity,
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}