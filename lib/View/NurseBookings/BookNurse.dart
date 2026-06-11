import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waada_customerapp/Controller/HomeController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Nurses/NursesListing.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/DateRangePicker.dart';
import '../../Widgets/ShiftTypeWidget.dart';
import '../../Widgets/TextInputWidget.dart';
import '../Home/CarouselSliderWidget.dart';
import '../Map/ChooseLocation.dart';

class BookNurse extends StatefulWidget {
  const BookNurse({super.key});

  @override
  State<BookNurse> createState() => _BookNurseState();
}

class _BookNurseState extends State<BookNurse> {
  HomeController homeController = Get.put(HomeController());

  String selectedLocation = "";
  String latitude = "";
  String longitude = "";
  String fromDate = "";
  String toDate = "";
  String selectedHourId = "1"; // Default to 4 Hours
  int searchCount = 0;

  @override
  void initState() {
    super.initState();
    homeController.fetchHours();
    _loadSearchCount();
  }

  Future<void> _loadSearchCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        searchCount = prefs.getInt('location_search_count') ?? 0;
      });
    } catch (e) {
      print("Error loading search count: $e");
    }
  }

  Future<void> _incrementSearchCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final newCount = (prefs.getInt('location_search_count') ?? 0) + 1;
      await prefs.setInt('location_search_count', newCount);
      setState(() {
        searchCount = newCount;
      });
    } catch (e) {
      print("Error incrementing search count: $e");
    }
  }

  void _showLocationBottomSheet(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    List<Map<String, String>> _popularSearches = [
      {"name": "New York"},
      {"name": "Los Angeles"},
      {"name": "Chicago"},
      {"name": "Houston"},
    ];
    List<dynamic> _searchResults = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      // ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _onSearchChanged(String query) {
              setState(() {
                _searchResults =
                    query.isEmpty
                        ? []
                        : List.generate(
                          5,
                          (index) => "$query, Result Area $index",
                        );
              });
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Back Button
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          "lib/Assets/Images/BackButton.svg",
                          fit: BoxFit.scaleDown,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        Strings.chooseLocation,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Search Box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Icon(Icons.search, color: Colors.grey),
                        // SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: InputDecoration(
                              hintText: Strings.chooseLocation,
                              hintStyle: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              fillColor: const Color(0xFFF3F3F3),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Popular Searches or Search Results
                  if (_searchResults.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Current Location Option
                        _buildLocationItem(
                          context,
                          icon: 'lib/Assets/Images/locationIcon.svg',
                          text: Strings.useCurrentLocation,
                          onTap: () async {
                            try {
                              bool serviceEnabled;
                              LocationPermission permission;

                              serviceEnabled =
                                  await Geolocator.isLocationServiceEnabled();
                              if (!serviceEnabled) {
                                return;
                              }

                              permission = await Geolocator.checkPermission();
                              if (permission == LocationPermission.denied) {
                                permission =
                                    await Geolocator.requestPermission();
                                if (permission == LocationPermission.denied) {
                                  return;
                                }
                              }

                              if (permission ==
                                  LocationPermission.deniedForever) {
                                return;
                              }

                              Position position =
                                  await Geolocator.getCurrentPosition();
                              setState(() {
                                latitude = position.latitude.toString();
                                longitude = position.longitude.toString();
                              });
                              try {
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                      position.latitude,
                                      position.longitude,
                                    );
                                if (placemarks.isNotEmpty) {
                                  Placemark place = placemarks.first;
                                  setState(() {
                                    selectedLocation =
                                        "${place.name}, ${place.locality}, ${place.administrativeArea}";
                                  });
                                } else {
                                  setState(() {
                                    selectedLocation = "Current Location";
                                  });
                                }
                              } catch (e) {
                                print("Reverse geocoding error: $e");
                                setState(() {
                                  selectedLocation = "Current Location";
                                });
                              }
                              _incrementSearchCount();
                              Get.back();
                            } catch (e) {
                              print("Error getting location: $e");
                            }
                          },
                        ),
                        // Select Places Option
                        _buildLocationItem(
                          context,
                          icon: 'lib/Assets/Images/locationIcon.svg',
                          text: Strings.selectPlaces,
                          onTap: () async {
                            final result = await Get.to(
                              () => ChooseLocation(isPicker: true),
                            );
                            if (result != null &&
                                result is Map<String, dynamic>) {
                              setState(() {
                                selectedLocation =
                                    result['name'] ?? "Selected Place";
                                latitude = result['lat'] ?? "";
                                longitude = result['long'] ?? "";
                              });
                              _incrementSearchCount();
                            }
                            Get.back();
                          },
                        ),
                        if (searchCount >= 5) ...[
                          SizedBox(height: 10),
                          Text(
                            Strings.popularSearch,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 200, // Set a fixed height for the ListView
                            child: ListView.builder(
                              itemCount: _popularSearches.length,
                              itemBuilder: (context, index) {
                                return _buildLocationItem(
                                  context,
                                  icon: 'lib/Assets/Images/locationIcon.svg',
                                  text: _popularSearches[index]['name']!,
                                  onTap: () async {
                                    final name = _popularSearches[index]['name']!;
                                    setState(() {
                                      selectedLocation = name;
                                    });
                                    try {
                                      List<Location> locations =
                                          await locationFromAddress(name);
                                      if (locations.isNotEmpty) {
                                        setState(() {
                                          latitude =
                                              locations.first.latitude.toString();
                                          longitude =
                                              locations.first.longitude
                                                  .toString();
                                        });
                                      }
                                    } catch (e) {
                                      print("Geocoding error: $e");
                                    }
                                    _incrementSearchCount();
                                    Get.back();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    )
                  else
                    SizedBox(
                      height: 300, // Set a fixed height for the ListView
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final resultName = _searchResults[index] as String;
                          return _buildLocationItem(
                            context,
                            icon: 'lib/Assets/Images/locationIcon.svg',
                            text: resultName,
                            onTap: () async {
                              setState(() {
                                selectedLocation = resultName;
                              });
                              try {
                                List<Location> locations =
                                    await locationFromAddress(resultName);
                                if (locations.isNotEmpty) {
                                  setState(() {
                                    latitude =
                                        locations.first.latitude.toString();
                                    longitude =
                                        locations.first.longitude.toString();
                                  });
                                }
                              } catch (e) {
                                print("Geocoding error: $e");
                              }
                              _incrementSearchCount();
                              Get.back();
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLocationItem(
    BuildContext context, {
    required String icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 1,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.nursebooking, showCloseIcon: false),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextStyleInterForSplash(
                text: Strings.location,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.00,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: InkWell(
                  onTap: () {
                    _showLocationBottomSheet(context);
                  },
                  child: TextInputWidget(
                    label:
                        selectedLocation.isEmpty
                            ? Strings.chooseLocation
                            : selectedLocation,
                    type: TextInputType.text,
                    height: 50,
                    onTap: () {
                      _showLocationBottomSheet(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.daterange,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.00,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: DateRangePicker(
                  onDateSelected: (start, end) {
                    setState(() {
                      fromDate =
                          "${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}";
                      toDate =
                          "${end.year}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}";
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.chooseshifttype,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.00,
              ),
              SizedBox(height: 10),
              GetBuilder<HomeController>(
                builder: (controller) {
                  if (controller.shiftHours.isEmpty) {
                    return const Center(
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: colorPrimary,
                          strokeWidth: 3,
                        ),
                      ),
                    );
                  }

                  // Set default selectedHourId if not set
                  if (selectedHourId == "1" &&
                      controller.shiftHours.isNotEmpty &&
                      controller.shiftHours[0]['id'].toString() != "1") {
                    // This is a safety check, but keeping "1" as default is usually fine
                  }

                  List<Widget> rows = [];
                  for (int i = 0; i < controller.shiftHours.length; i += 2) {
                    rows.add(
                      Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ShiftTypeWidget(
                                text:
                                    "${controller.shiftHours[i]['hour']} Hours",
                                isSelected:
                                    selectedHourId ==
                                    controller.shiftHours[i]['id'].toString(),
                                onTap:
                                    () => setState(
                                      () =>
                                          selectedHourId =
                                              controller.shiftHours[i]['id']
                                                  .toString(),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (i + 1 < controller.shiftHours.length)
                              Expanded(
                                child: ShiftTypeWidget(
                                  text:
                                      "${controller.shiftHours[i + 1]['hour']} Hours",
                                  isSelected:
                                      selectedHourId ==
                                      controller.shiftHours[i + 1]['id']
                                          .toString(),
                                  onTap:
                                      () => setState(
                                        () =>
                                            selectedHourId =
                                                controller
                                                    .shiftHours[i + 1]['id']
                                                    .toString(),
                                      ),
                                ),
                              )
                            else
                              Expanded(child: Container()),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(children: rows);
                },
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: SubmitButtonWidget(
                  onTap: () {
                    if (selectedLocation.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a location")),
                      );
                      return;
                    }
                    if (fromDate.isEmpty || toDate.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a date range")),
                      );
                      return;
                    }
                    Get.to(
                      () => NursesListing(),
                      arguments: {
                        "location": selectedLocation,
                        "start_date": fromDate,
                        "end_date": toDate,
                        "hour_id": selectedHourId,
                        "latitude": latitude,
                        "longitude": longitude,
                      },
                    );
                  },
                  text: Strings.search,
                ),
              ),
              SizedBox(height: 30),
              CarouselSliderWidget(
                currentIndex: homeController.currentIndex,
                imageUrls: homeController.imageUrls,
                onPageChanged: (index) {
                  setState(() {
                    homeController.currentIndex = index;
                    homeController.update();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
