import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/Controller/LaboratoryController.dart';
import 'package:waada_customerapp/Resource/Strings.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';
import 'package:waada_customerapp/Widgets/LaboratoryDetailsWidget.dart';
import 'package:waada_customerapp/Widgets/SearchbardWidget.dart';

class Laboratory extends StatefulWidget {
  const Laboratory({super.key});

  @override
  State<Laboratory> createState() => _LaboratoryState();
}

class _LaboratoryState extends State<Laboratory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(label:Strings.laboratories,
        showCloseIcon: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder(
          init: LaboratoryController(),
          builder:(controller) =>  Column(
            children: [
              SearchBarWidget(labelText: Strings.searchLaboratory),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return LaboratoryDetailswidget(
                      onAllServicesTapped: () {
                        controller.showLaboratoryDetailsBottomSheet(context);
                      },
                      buttonText: Strings.bookNow,
                      moreOptions: index % 2 == 0,
                    );
                  },
                  separatorBuilder:
                      (context, index) => SizedBox(height: 20),
                  itemCount: 2,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        )
      ),
    );
  }
}
