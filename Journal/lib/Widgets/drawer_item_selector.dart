import 'package:flutter/material.dart';

class DrawerItemSelector with ChangeNotifier {

  Color notesButtonColor = Color(0xFF042743);
  Color trashButtonColor = Color(0xFF042743);
  Color aboutButtonColor = Color(0xFF042743);

  Color notesButtonHighLightColor = Color(0xFF042743).withOpacity(0.4);
  Color trashButtonHighLightColor = Colors.transparent;
  Color aboutButtonHighLightColor = Colors.transparent;

 String buttonName = "Notes";

  void changeButtonColor({@required String buttonName}) {
    switch (buttonName) {
      case "Notes":
        notesButtonHighLightColor = notesButtonColor.withOpacity(0.4);
        trashButtonHighLightColor = Colors.transparent;
        aboutButtonHighLightColor = Colors.transparent;

        trashButtonColor = Color(0xFF042743);
        aboutButtonColor = Color(0xFF042743);

        buttonName = "Notes";

        break;

      case "Trash":
        notesButtonHighLightColor = Colors.transparent;
        trashButtonHighLightColor = Colors.green[100];
        aboutButtonHighLightColor = Colors.transparent;

        notesButtonColor = Color(0xFF042743);
        trashButtonColor = Colors.green;
        aboutButtonColor = Color(0xFF042743);

        buttonName = "Trash";
        break;

      case "About":
        notesButtonHighLightColor = Colors.transparent;
        trashButtonHighLightColor = Colors.transparent;
        aboutButtonHighLightColor = Colors.red[100];

        notesButtonColor = Color(0xFF042743);
        trashButtonColor = Color(0xFF042743);
        aboutButtonColor = Colors.red;

        buttonName = "About";
    }

    notifyListeners();
  }
}
