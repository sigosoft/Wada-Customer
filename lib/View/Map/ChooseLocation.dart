import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Home/Home.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Profile/SubmitButtonWidget.dart';
import 'package:waada_customerapp/Controller/MapController.dart';
import 'package:get/get.dart';

class ChooseLocation extends StatefulWidget {
  final bool isPicker;
  const ChooseLocation({super.key, this.isPicker = false});

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final MapController controller = Get.put(MapController());

  @override
  void initState() {
    super.initState();
    controller.getCurrentPosition();
  }

  void _setMapStyle() async {
    String style = '''
  [
    {
      "featureType": "all",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    }
  ]
  ''';
    controller.mapController?.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder:
          (controller) => Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                // Google Map
                GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  markers: controller.marker,
                  initialCameraPosition: CameraPosition(
                    target:
                        controller.currentPosition ??
                        const LatLng(37.7749, -122.4194),
                    zoom: 18.0,
                  ),
                  onMapCreated: (GoogleMapController mapController) {
                    controller.mapController = mapController;
                    _setMapStyle();
                  },
                  onCameraMove: (position) {
                    controller.currentPosition = position.target;
                  },
                  onCameraIdle: () {
                    if (controller.currentPosition != null) {
                      controller.getAddressFromLatLng(
                        controller.currentPosition!,
                      );
                    }
                  },
                ),
                Center(
                  child: SvgPicture.asset(
                    'lib/Assets/Images/locationbutton.svg',
                    width: 80,
                    height: 80,
                  ),
                ),
                // Search Bar
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: white, size: 23),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                cursorColor: white,
                                controller: controller.searchController,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    controller.getSuggestion(value);
                                  } else {
                                    controller.placeList.clear();
                                    controller.update();
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: Strings.searchplace,
                                  hintStyle: GoogleFonts.inter(
                                    color: white,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.inter(
                                  color: white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Dropdown for search results
                      if (controller.placeList.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.placeList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: SvgPicture.asset(
                                  'lib/Assets/Images/locationIcon.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                title: Text(
                                  controller.placeList[index],
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  final selectedPlace = controller.placeList[index];
                                  controller.searchController.text = selectedPlace;
                                  controller.resolvePlace(selectedPlace);
                                  controller.placeList.clear();
                                  controller.update();
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // Bottom Container
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'lib/Assets/Images/locationIcon.svg',
                              width: 23,
                              height: 23,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    controller.place?.locality ??
                                        "Selecting...",
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    controller.location.value.isEmpty
                                        ? "..."
                                        : controller.location.value,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SubmitButtonWidget(
                          onTap: () {
                            if (widget.isPicker) {
                              Get.back(
                                result: {
                                  "name": controller.location.value,
                                  "lat":
                                      controller.currentPosition?.latitude
                                          .toString(),
                                  "long":
                                      controller.currentPosition?.longitude
                                          .toString(),
                                },
                              );
                            } else {
                              Get.to(Home());
                            }
                          },
                          text: Strings.verifylocation,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
