import 'package:burn_ada/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:burn_ada/app_page.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );

    if (kIsWeb) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Burn Ada',
        home: LandingPage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Burn Ada',
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: "assets/splash.png",
          nextScreen: AppPage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Color(0xFF30083E),
        ),
      );
    }
  }
}
