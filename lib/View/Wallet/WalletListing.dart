import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Controller/WalletController.dart';
import 'package:waada_customerapp/Widgets/CustomAppBar.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';
import '../../Resource/Strings.dart';
import '../../Resource/colors.dart';
import '../Login/SubmitButtonWidget.dart';
import 'WalletItem.dart';

class WalletListing extends StatefulWidget {
  const WalletListing({Key? key}) : super(key: key);

  @override
  State<WalletListing> createState() => _WalletListingState();
}

class _WalletListingState extends State<WalletListing> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      init: WalletController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            label: Strings.walletTitle,
            showBackButton: true,
            showCloseIcon: false,
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showComingSoonDialog(context);
            },
            child:
                controller.isLoading.value
                    ? const Center(
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: colorPrimary,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                    : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [colorPrimary, colorPrimaryDark1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.availableCoins
                                              .toStringAsFixed(0),
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          "1 Coin = ${controller.pointRate} AED",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.totalCoinsAvailable,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Text(
                                      Strings.maxAmountInfo,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: SubmitButtonWidget(
                                      onTap: () {},
                                      text: Strings.addMoneyascoin,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              Strings.transactions,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            controller.walletLogs.isEmpty
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                      "No transactions found",
                                      style: GoogleFonts.inter(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                                : ListView.builder(
                                  itemCount: controller.walletLogs.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var log = controller.walletLogs[index];
                                    return WalletItem(log: log);
                                  },
                                ),
                          ],
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }
}
