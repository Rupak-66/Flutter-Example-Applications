import 'package:flutter/material.dart';
import 'package:journal/Widgets/custom_drawer.dart';

class Trash extends StatefulWidget {
  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("TRASH"),
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
