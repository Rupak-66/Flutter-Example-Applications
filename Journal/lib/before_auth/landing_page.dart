import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  bool opacityAnimationDone = false;

  AnimationController _opacityController;
  Animation _opacityAnimation;
  Animation _offSetAnimation;
  AnimationController _slidingController;

  void animateSliding() {
    _slidingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.of(context).pushReplacementNamed("Decider");
            }
          });

    //TODO: Need assure that the offset is based on the device size

    _offSetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, 0.0)).animate(
            CurvedAnimation(
                parent: _slidingController, curve: Curves.elasticIn));
    _slidingController.forward();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _opacityController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addStatusListener((val) {
            if (val == AnimationStatus.completed) {
              setState(() {
                opacityAnimationDone = true;
              });
              animateSliding();
            }
          });

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_opacityController);

    _opacityController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _opacityController.dispose();
    _slidingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: mobileLayout(mediaHeight),
      ),
    );
  }

  Widget mobileLayout(double mediaHeight) {
    return Padding(
      padding: EdgeInsets.all(mediaHeight * 0.02),
      child: Center(
          child: opacityAnimationDone
              ? SlideTransition(
                  position: _offSetAnimation,
                  child: Text(
                    "Journal",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: "Title",
                        fontSize: mediaHeight * 0.135),
                  ),
                )
              : FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    "Journal",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: "Title",
                        fontSize: mediaHeight * 0.135),
                  ),
                )),
    );
  }
}
