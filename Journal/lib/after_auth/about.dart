import 'package:flutter/material.dart';
import 'package:journal/Widgets/custom_drawer.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("ABOUT"),
      ),
      body: Center(
          child: Text(
        "Coming Soon...",
        style: TextStyle(
            fontFamily: "Title",
            fontSize: 30.0,
            color: Theme.of(context).primaryColor),
      )),
    );
  }
}
