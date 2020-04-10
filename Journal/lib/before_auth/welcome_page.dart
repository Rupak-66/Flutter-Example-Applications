import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal/services/auth_service.dart';

import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    AuthService _provider = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(mediaHeight * .01, mediaHeight * .03,
                  mediaHeight * .01, mediaHeight * .01),
              child: Center(
                child: Column(children: <Widget>[
                  SvgPicture.asset("assets/welcome.svg",
                      height: mediaHeight * .36),
                  SizedBox(height: mediaHeight * .015),
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontFamily: "Title", fontSize: mediaHeight * .07),
                  ),
                  SizedBox(height: mediaHeight * .001),
                  Text(
                    "to Journal. We will help you to record your daily journals",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: mediaHeight * .03,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: mediaHeight * .05),
                  buildButtonRow(mediaHeight, _provider),
                  SizedBox(height: mediaHeight * .05),
                  Text("Login via following",
                      style: TextStyle(
                          color: Colors.grey, fontSize: mediaHeight * .025)),
                  SizedBox(height: mediaHeight * .02),
                  buildSocialButtonsRow(mediaHeight, _provider),
                ]),
              ))),
    );
  }

  Row buildSocialButtonsRow(double mediaHeight, AuthService provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          iconSize: mediaHeight * .06,
          onPressed: () {
            provider.facebookSignin();
          },
          icon: Icon(EvaIcons.facebookOutline),
        ),
        IconButton(
          iconSize: mediaHeight * .06,
          onPressed: () {
            provider.googleSignin();
          },
          icon: Icon(EvaIcons.googleOutline),
        ),
        IconButton(
          iconSize: mediaHeight * .06,
          onPressed: () {
            provider.twitterSignin();
          },
          icon: Icon(EvaIcons.twitterOutline),
        )
      ],
    );
  }

  Row buildButtonRow(double mediaHeight, AuthService provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //* Contact Me
        MaterialButton(
            padding: EdgeInsets.symmetric(
                vertical: mediaHeight * .02, horizontal: mediaHeight * .05),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () => provider.contactMe(
                'mailto:chinkysight@gmail.com?subject=Journal,%20Contact Me&body=Hello%20chinkysight,'),
            color: Theme.of(context).primaryColor,
            child: Text(
              "Contact",
              style:
                  TextStyle(color: Colors.white, fontSize: mediaHeight * .03),
            )),
        SizedBox(
          width: mediaHeight * .02,
        ),
        //* Instagram Follow Button
        MaterialButton(
          padding: EdgeInsets.symmetric(
              vertical: mediaHeight * .02, horizontal: mediaHeight * .06),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), side: BorderSide()),
          onPressed: () =>
              provider.followMe("https://www.instagram.com/chinkysight/?hl=en"),
          child: Text(
            "Follow",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: mediaHeight * .03),
          ),
        ),
      ],
    );
  }
}
