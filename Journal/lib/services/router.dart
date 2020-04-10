import 'package:flutter/material.dart';
import 'package:journal/after_auth/about.dart';
import 'package:journal/after_auth/notes.dart';
import 'package:journal/after_auth/trash.dart';

import 'package:journal/after_auth/write_journal.dart';
import 'package:journal/before_auth/landing_page.dart';
import 'package:journal/before_auth/welcome_page.dart';
import 'package:journal/before_auth/wrapper.dart';

class Router {
  static Route generateRoutes(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case "LandingPage":
        return MaterialPageRoute(builder: (_) => LandingPage());
        break;
      case "Decider":
        return MaterialPageRoute(builder: (_) => Wrapper());
        break;
      case "WelcomePage":
        return MaterialPageRoute(builder: (_) => WelcomePage());
        break;
      case "Home":
        return MaterialPageRoute(builder: (_) => Notes());

        break;
      case "WriteJournal":
        return MaterialPageRoute(
            builder: (_) => WriteJournal(documentSnapshot: args));
        break;

         case "Notes":
      return MaterialPageRoute(builder: (_)=> Notes());
      break;
      
      case "Trash":
      return MaterialPageRoute(builder: (_)=> Trash());
      break;
       case "About":
      return MaterialPageRoute(builder: (_)=> About());
      break;
      default:
        return null;
    }
  }
}
