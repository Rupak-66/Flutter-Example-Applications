import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Text(
          "Contacts",
          style: GoogleFonts.petrona(
              textStyle: TextStyle(color: Colors.tealAccent, fontSize: 40.0)),
        ),
      ),
    ));
  }
}
