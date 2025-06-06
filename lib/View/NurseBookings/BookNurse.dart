import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/HomeController.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/Login/SubmitButtonWidget.dart';
import 'package:waada_customerapp/View/Nurses/NursesListing.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../../Widgets/CustomAppBar.dart';
import '../../Widgets/DateRangePicker.dart';
import '../../Widgets/ShiftTypeWidget.dart';
import '../../Widgets/TextInputWidget.dart';
import '../Home/CarouselSliderWidget.dart';

class BookNurse extends StatefulWidget {
  const BookNurse({super.key});

  @override
  State<BookNurse> createState() => _BookNurseState();
}

class _BookNurseState extends State<BookNurse> {
  HomeController homeController = Get.put(HomeController());

  void _showLocationBottomSheet(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    List<String> _popularSearches = [
      "New York",
      "Los Angeles",
      "Chicago",
      "Houston",
    ];
    List<String> _searchResults = [];

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
                        : List.generate(5, (index) => "$query Result $index");
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
                      SizedBox(width: 10,),
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
                      color:  Color(0xFFF3F3F3),
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
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(children:[
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'lib/Assets/Images/locationIcon.svg',
                                        width: 20,
                                        height: 20,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          _popularSearches[index],
                                          style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5E5E5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ])
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      height: 300, // Set a fixed height for the ListView
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'lib/Assets/Images/locationIcon.svg',
                                      width: 20,
                                      height: 20,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _searchResults[index],
                                        style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
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
                    label: Strings.chooseLocation,
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
                child: DateRangePicker(),
              ),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: Strings.chooseshifttype,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 14.00,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(child: ShiftTypeWidget(text: "4 Hours")),
                    SizedBox(width: 10),
                    Expanded(child: ShiftTypeWidget(text: "8 Hours")),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  children: [
                    Expanded(child: ShiftTypeWidget(text: "12 Hours")),
                    SizedBox(width: 10),
                    Expanded(child: ShiftTypeWidget(text: "24 Hours")),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: SubmitButtonWidget(
                  onTap: () {
                    Get.to(NursesListing());
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
