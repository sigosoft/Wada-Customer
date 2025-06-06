import 'package:flutter/material.dart';
import 'package:waada_customerapp/Resource/Colors.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/CustomExpansionTileForConsultationRecords.dart';
import 'package:waada_customerapp/View/HealthCardMedicalRecords/CustomExpansionTileWidget.dart';

class CustomTabBarWidget extends StatelessWidget {
  final List<String> itemList;
  final dynamic controller;
  final dynamic switchValue;
  final dynamic tabController;

  const CustomTabBarWidget({
    Key? key,
    required this.itemList,
    this.controller,
    this.switchValue,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: itemList.length,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: colorPrimary,
              indicatorColor: colorPrimary,
              isScrollable: true,
              dividerColor: Colors.transparent,
              tabs: List.generate(itemList.length, (index) {
                return Tab(text: itemList[index]);
              }),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: controller.sizedBoxHeight,
            child: TabBarView(
              children: List.generate(itemList.length, (index) {
                final currentItem = itemList[index];
                final filteredList = itemList.where((e) => e != "All").toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:
                      switchValue
                          ? CustomExpansionTileWidget(
                            controller: controller,
                            name: currentItem,
                            notes: Strings.dummy,
                            attachmentList: controller.attatchmentList,
                          )
                          : CustomExpansionTileWidgetForConsultationRecords(
                            controller: controller,
                            name: currentItem,
                            notes: Strings.dummy,
                            attachmentList: controller.attatchmentList,
                            doctorName: "Ahmed Khan",
                          ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
