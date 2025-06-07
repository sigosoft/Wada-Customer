import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waada_customerapp/View/Splash/Splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    );
  }
}


