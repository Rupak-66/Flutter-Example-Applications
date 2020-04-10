import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal/Widgets/drawer_item_selector.dart';

import 'package:journal/services/auth_service.dart';
import 'package:journal/services/backend_service.dart';
import 'package:journal/services/router.dart';

import 'package:journal/utils/project_colors.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => AuthService()),
      Provider(create: (_) => BackendService()),
      ChangeNotifierProvider<DrawerItemSelector>(create: (_)=> DrawerItemSelector()),
      
      // FutureProvider<bool>.value(value: checkInternetConnection()),
      StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged)
    ],
    child: MaterialApp(
      theme: ThemeData(
        //* We are changing the SearchDelegate's appbar hinttext color and textfield color
        hintColor: Colors.grey,
        cursorColor: Colors.white,
        textTheme: TextTheme(title: TextStyle(color: Colors.white)),

        appBarTheme: AppBarTheme(
          textTheme:
              TextTheme(title: TextStyle(color: Colors.white, fontSize: 22.0)),
          iconTheme: IconThemeData(color: Colors.white),
          color: ProjectColors.primaryColor,
          elevation: 0.0,
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),

        primaryColor: ProjectColors.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "LandingPage",
      onGenerateRoute: Router.generateRoutes,
    ),
  ));
}
