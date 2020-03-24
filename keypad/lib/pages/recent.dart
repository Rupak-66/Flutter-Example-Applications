import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Text(
          "Recents",
          style:
              GoogleFonts.portLligatSlab(color: Colors.orange, fontSize: 40.0),
        ),
      ),
    ));
  }
}
