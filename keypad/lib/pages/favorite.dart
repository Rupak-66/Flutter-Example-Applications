import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Text(
        "Favorite",
        style: GoogleFonts.pathwayGothicOne(
            textStyle: TextStyle(
                letterSpacing: 1.0, color: Colors.yellow, fontSize: 40.0)),
      )),
    ));
  }
}
