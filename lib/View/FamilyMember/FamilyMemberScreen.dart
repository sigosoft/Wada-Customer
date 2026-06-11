import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/FamilyMemberController.dart';
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
      body: GetBuilder<FamilyMemberController>(
        init: FamilyMemberController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.controller?.fetchMembers();
          });
        },
        builder: (controller) {
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: colorPrimary))
              : SafeArea(
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
                        child:
                            controller.membersList.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'lib/Assets/Images/No data.png',
                                        height: 150,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        "No family Members added",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: profileText,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : ListView.separated(
                                  itemCount: controller.membersList.length,
                                  itemBuilder: (context, index) {
                                    var member = controller.membersList[index];
                                    return FamilyCardWidget(
                                      name: member['name'] ?? "",
                                      relation: member['relationship'] ?? "",
                                      gender:
                                          member['gender']?.toString() == "1"
                                              ? "Male"
                                              : "Female",
                                      dob: member['dob'] ?? "",
                                      phoneNo:
                                          "${member['country_code'] ?? ''} ${member['mobile'] ?? ''}",
                                      address: member['address'] ?? "",
                                      onDeleteTapped: () {
                                        if (member['id'] != null) {
                                          controller.deleteMember(member['id']);
                                        }
                                      },
                                      onEditTapped: () {
                                        controller.setEditData(member);
                                        Get.to(() => const AddFamilyMembers());
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 20);
                                  },
                                ),
                      ),
                      SubmitButtonWithBorderColor(
                        text: Strings.addFamilyMember,
                        onTap: () {
                          controller.clearForm();
                          Get.to(() => const AddFamilyMembers());
                        },
                      ),
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }
}
