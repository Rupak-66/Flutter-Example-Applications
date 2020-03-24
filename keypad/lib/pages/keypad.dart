import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:keypad/logic.dart';

class Keypad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Logic>(
      builder: (_, logic, __) => Padding(
        padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              logic.key,
              style: TextStyle(fontSize: 40.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 25.0),
            KeyPad(
              firstKey: 1,
              secondKey: 2,
              thirdKey: 3,
            ),
            SizedBox(height: 16.0),
            KeyPad(
              firstKey: 4,
              secondKey: 5,
              thirdKey: 6,
            ),
            SizedBox(height: 16.0),
            KeyPad(
              firstKey: 7,
              secondKey: 8,
              thirdKey: 9,
            ),
            SizedBox(height: 16.0),
            KeyPad(
              firstKey: '*',
              secondKey: 0,
              thirdKey: '#',
            ),
            SizedBox(height: 30.0),
            KeyPad(
              firstIcon: Icon(Icons.videocam, size: 35.0),
              secondIcon: Icon(
                Icons.phone,
                size: 35.0,
              ),
              thirdIcon: Icon(Icons.backspace, size: 30.0),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  final firstKey;
  final secondKey;
  final thirdKey;
  final firstIcon;
  final secondIcon;
  final thirdIcon;
  KeyPad(
      {this.firstKey,
      this.secondKey,
      this.thirdKey,
      this.firstIcon,
      this.secondIcon,
      this.thirdIcon});

  final TextStyle _style = TextStyle(fontSize: 25.0);

  bool _iconAvailable() {
    return (firstIcon != null && thirdIcon != null && secondIcon != null);
  }

  @override
  Widget build(BuildContext context) {
    Logic _provider = Provider.of<Logic>(context, listen: false);

    return Row(
      children: <Widget>[
        //* first button
        Expanded(
            child: _iconAvailable()
                ? RawMaterialButton(
                    padding: EdgeInsets.all(15.0),
                    child: Center(child: firstIcon),
                    onPressed: () => _provider.keyPressHandler("Video Call"),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent)),
                  )
                : RawMaterialButton(
                    padding: EdgeInsets.all(15.0),
                    child:
                        Center(child: Text(firstKey.toString(), style: _style)),
                    onPressed: () =>
                        _provider.keyPressHandler(firstKey.toString()),
                    shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  )

            //* second button

            ),
        Expanded(
          child: _iconAvailable()
              ? RawMaterialButton(
                  fillColor: Colors.green,
                  padding: EdgeInsets.all(15.0),
                  child: Center(child: secondIcon),
                  onPressed: () => _provider.keyPressHandler("Call"),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                )
              : RawMaterialButton(
                  fillColor: Colors.transparent,
                  padding: EdgeInsets.all(15.0),
                  child:
                      Center(child: Text(secondKey.toString(), style: _style)),
                  onPressed: () =>
                      _provider.keyPressHandler(secondKey.toString()),
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                ),
        ),

        //* third button

        Expanded(
          child: _iconAvailable()
              ? RawMaterialButton(
                  padding: EdgeInsets.all(15.0),
                  child: Center(child: thirdIcon),
                  onPressed: () => _provider.keyPressHandler("Backspace"),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                )
              : RawMaterialButton(
                  padding: EdgeInsets.all(15.0),
                  child:
                      Center(child: Text(thirdKey.toString(), style: _style)),
                  onPressed: () =>
                      _provider.keyPressHandler(thirdKey.toString()),
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                ),
        ),
      ],
    );
  }
}
