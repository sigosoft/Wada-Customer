import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/FamilyMember/AddFamilyMembers.dart';
import 'package:waada_customerapp/View/FamilyMember/FamilyCardWidget.dart';
import 'package:waada_customerapp/View/FamilyMember/SubmitButtonWithBorderColor.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class FamilyMemberScreen extends StatefulWidget {
  const FamilyMemberScreen({super.key});

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.familyMembers),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                child: Container(height: 1, color: Colors.transparent),
              ),
              SizedBox(height: 15),
              TextStyleInterForSplash(
                text: "Members",
                color: blackTextColor2,
                fontWeight: FontWeight.w600,
                size: 16.00,
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  itemBuilder:(context, index) {
                 return FamilyCardWidget(
                    name: "George Jacob",
                    relation: "Father",
                    gender: "Male",
                    dob: "18 Oct 1956",
                    phoneNo: "+91 987654321",
                    address:
                    "New Rajendra Nagar, Amlihdih, New Rajendra Nagar, Raipur, Tikrapara, Chhattisgarh 492001",
                    onDeleteTapped: () {},
                    onEditTapped: () {},
                  );
                },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
              ),),
              SubmitButtonWithBorderColor(
                text: Strings.addFamilyMember,
                onTap: (){
                  Get.to(AddFamilyMembers());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}






