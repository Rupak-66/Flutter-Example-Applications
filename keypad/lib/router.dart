import 'package:flutter/material.dart';

import './pages/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('Home'):
        return MaterialPageRoute(builder: (_) => Home());

      default:
        return null;
    }
  }
}
