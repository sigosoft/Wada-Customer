import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/View/Bookings/Bookings.dart';
import 'package:waada_customerapp/View/Home/HomeItem.dart';
import 'package:waada_customerapp/View/Profile/Profile.dart';
import 'package:waada_customerapp/View/ServiceListing/ServiceListing.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeItem(),
    ServiceListing(),
    Bookings(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle:GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        selectedLabelStyle:GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ), 
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(_selectedIndex==0?"lib/Assets/Images/BottomNavIcon1.svg":"lib/Assets/Images/bottomNavIcon1Unselected.svg",fit: BoxFit.scaleDown,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(_selectedIndex==1?"lib/Assets/Images/botomNavIcon2Selected.svg":"lib/Assets/Images/BottomNavIcon2.svg",fit: BoxFit.scaleDown,),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(_selectedIndex==2?"lib/Assets/Images/BottomNavIcon3.svg":"lib/Assets/Images/BottomNavIcon3Unselected.svg",fit: BoxFit.scaleDown,),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(_selectedIndex==3?"lib/Assets/Images/bottomnavIcon4Selected.svg":"lib/Assets/Images/BottomNavIcon4.svg",fit: BoxFit.scaleDown,),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}