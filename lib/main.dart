import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_tracking_project/views/home_ui.dart';
import 'package:money_tracking_project/views/login_ui.dart';
import 'package:money_tracking_project/views/splash_screen_ui.dart';
// import 'package:money_tracking_project/views/home_ui.dart';


void main() {
  runApp(const MoneyTrackingApp());
}

//------------------------------------------

class MoneyTrackingApp extends StatefulWidget {
  const MoneyTrackingApp({super.key});

  @override
  State<MoneyTrackingApp> createState() => _MoneyTrackingAppState();
}

class _MoneyTrackingAppState extends State<MoneyTrackingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),    
      ),
    );
  }
}
