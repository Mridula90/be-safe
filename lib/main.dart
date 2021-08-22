import 'package:be_safe/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(
        Theme.of(context).textTheme,
      )),
      home: Signin(),
      // Maps(LatLng(29.3247651, 48.0640304)),
      debugShowCheckedModeBanner: false,
    );
  }
}
