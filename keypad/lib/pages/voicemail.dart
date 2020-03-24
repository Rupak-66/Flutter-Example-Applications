import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoiceMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Text(
          "VoiceMail",
          style:
              GoogleFonts.ranchers(color: Colors.amberAccent, fontSize: 40.0),
        ),
      ),
    ));
  }
}
