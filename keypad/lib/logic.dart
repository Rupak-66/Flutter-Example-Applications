import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keypad/pages/contacts.dart';
import 'package:keypad/pages/keypad.dart';
import 'package:keypad/pages/voicemail.dart';
import './pages/favorite.dart';
import './pages/recent.dart';

class Logic with ChangeNotifier {
  String key = "";
  int selectedIndex = 3;

  void keyPressHandler(String input) {
    switch (input) {
      case ('Video Call'):
        Fluttertoast.showToast(
            msg: "Video Calling...", toastLength: Toast.LENGTH_SHORT);

        break;

      case ('Call'):
        Fluttertoast.showToast(
            msg: "Calling...", toastLength: Toast.LENGTH_SHORT);
        break;

      case ('Backspace'):
        int _length = key.length;

        key = key.substring(0, (_length - 1));

        break;

      default:
        key = key + input;
    }
    notifyListeners();
  }

  void onNavItemTapped(int index) {
    selectedIndex = index;

    notifyListeners();
  }

  Widget switchPage() {
    switch (selectedIndex) {
      case 0:
        return Favorites();

      case 1:
        return Recents();

      case 2:
        return Contacts();

      case 3:
        return Keypad();

      case 4:
        return VoiceMail();

      default:
        return Container();
    }
  }
}
