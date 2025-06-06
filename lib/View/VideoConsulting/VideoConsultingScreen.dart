import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waada_customerapp/Widgets/widgets.dart';

class VideoConsultingScreen extends StatefulWidget {
  const VideoConsultingScreen({super.key});

  @override
  State<VideoConsultingScreen> createState() => _VideoConsultingScreenState();
}

class _VideoConsultingScreenState extends State<VideoConsultingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'lib/Assets/Images/patientVideoCallImageDummy.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextStyleInterWithoutPadding(
                      textAlign: TextAlign.start,
                      text: "Dr.Ahmed Khan",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      size: 16.0,
                    ),
                    const SizedBox(height: 5),
                    TextStyleInterWithoutPadding(
                      textAlign: TextAlign.start,
                      text: "05:11",
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      size: 13.0,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        'lib/Assets/Images/patientVideoCallImageDummy2.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCallButton("lib/Assets/Images/micIcon.svg"),
                    _buildCallButton("lib/Assets/Images/videoIcon.svg"),
                    _buildCallButton("lib/Assets/Images/flipCameraIcon.svg"),
                    _buildCallButton(
                      "lib/Assets/Images/endCallIcon.svg",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton(String icon, {Color color = Colors.white}) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width * 0.07,
      backgroundColor: color,
      child: SvgPicture.asset(icon),
    );
  }
}
