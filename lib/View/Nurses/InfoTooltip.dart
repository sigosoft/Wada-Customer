import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waada_customerapp/Resource/Colors.dart';

class InfoTooltip extends StatefulWidget {
  const InfoTooltip({Key? key}) : super(key: key);

  @override
  State<InfoTooltip> createState() => _InfoTooltipState();
}

class _InfoTooltipState extends State<InfoTooltip> {
  final _tooltipController = SuperTooltipController();

  Future<bool> _willPopCallback() async {
    if (_tooltipController.isVisible) {
      await _tooltipController.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: GestureDetector(
        onTap: () async {
          await _tooltipController.showTooltip();
        },
        child: SuperTooltip(
          controller: _tooltipController,
          popupDirection: TooltipDirection.down,
          backgroundColor: Colors.white,
          borderColor: Colors.grey.shade300,
          borderRadius: 8.0,
          arrowTipDistance: 10.0,
          arrowBaseWidth: 15.0,
          arrowLength: 10.0,
          showBarrier: true,
          barrierColor: Colors.black.withOpacity(0.1),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Injection Services",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 25, color: Colors.black),
                          onPressed: () async {
                            await _tooltipController.hideTooltip();
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "• ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(
                            child: Text(
                              "Administering intramuscular, intravenous, and subcutaneous injections.",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color:blackTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "• ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Expanded(
                            child: Text(
                              " Insulin administration for diabetic patients.",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: blackTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: Icon(Icons.info_outlined, size: 18, color: Colors.black),
        ),
      ),
    );
  }
}