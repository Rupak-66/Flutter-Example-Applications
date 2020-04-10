import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:journal/after_auth/inner_wrapper.dart';

import 'package:journal/before_auth/welcome_page.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user != null) {
      return InnerWrapper();
    }
    return WelcomePage();
  }
}
