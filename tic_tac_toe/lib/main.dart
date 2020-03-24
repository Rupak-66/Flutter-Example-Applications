import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, String> rootMap = {
    'topLeft': 'a',
    'topMid': 'b',
    'topRight': 'c',
    'midLeft': 'd',
    'midMid': 'e',
    'midRight': 'f',
    'bottomLeft': 'g',
    'bottomMid': 'h',
    'bottomRight': 'i'
  };

  String ticTacToeSign = "O";

  void mainFunction(
      {@required String pressedKey, @required double constraintHeight}) {
    setState(() {
      if (!(rootMap[pressedKey] == 'X' || rootMap[pressedKey] == 'O')) {
        rootMap[pressedKey] = ticTacToeSign;

        String properSign = ticTacToeSign;

        if (ticTacToeSign == "O") {
          ticTacToeSign = "X";
        } else {
          ticTacToeSign = "O";
        }

        if ((rootMap['topLeft'] == rootMap['topMid'] &&
                    rootMap['topMid'] == rootMap['topRight']) ||
                (rootMap['midLeft'] == rootMap['midMid'] &&
                    rootMap['midMid'] == rootMap['midRight']) ||
                (rootMap['bottomLeft'] == rootMap['bottomMid'] &&
                    rootMap['bottomMid'] == rootMap['bottomRight']) ||

                //* Three linear horizontal probability ends here

                (rootMap['topLeft'] == rootMap['midLeft'] &&
                    rootMap['midLeft'] == rootMap['bottomLeft']) ||
                (rootMap['topMid'] == rootMap['midMid'] &&
                    rootMap['midMid'] == rootMap['bottomMid']) ||
                (rootMap['topRight'] == rootMap['midRight'] &&
                    rootMap['midRight'] == rootMap['bottomRight']) ||
                //* Three linear vertical probability ends here

                (rootMap['topLeft'] == rootMap['midMid'] &&
                    rootMap['midMid'] == rootMap['bottomRight']) ||

                //* The diagonal probability starting from topLeft to bottomRight ends here

                (rootMap['topRight'] == rootMap['midMid'] &&
                    rootMap['midMid'] == rootMap['bottomLeft'])
            //* The diagonal probability starting from topRight to bottomLeft ends here
            ) {
          showDialog(
              context: context,
              barrierDismissible: false,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "$properSign Won",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProperConstraint(
                                constraintHeight: constraintHeight,
                                percent: 18)),
                      ),
                      SizedBox(
                          height: getProperConstraint(
                              constraintHeight: constraintHeight, percent: 10)),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            rootMap.forEach((k, v) {
                              switch (k) {
                                case 'topLeft':
                                  rootMap[k] = 'a';
                                  break;

                                case 'topMid':
                                  rootMap[k] = 'b';
                                  break;

                                case 'topRight':
                                  rootMap[k] = 'c';
                                  break;

                                case 'midLeft':
                                  rootMap[k] = 'd';
                                  break;
                                case 'midMid':
                                  rootMap[k] = 'e';
                                  break;
                                case 'midRight':
                                  rootMap[k] = 'f';
                                  break;

                                case 'bottomLeft':
                                  rootMap[k] = 'g';
                                  break;
                                case 'bottomMid':
                                  rootMap[k] = 'h';
                                  break;
                                case 'bottomRight':
                                  rootMap[k] = 'i';
                                  break;

                                default:
                                  break;
                              }
                            });
                          });

                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: getProperConstraint(
                                constraintHeight: constraintHeight, percent: 5),
                            vertical: getProperConstraint(
                                constraintHeight: constraintHeight,
                                percent: 8)),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                            child: Text(
                          "Play Again",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProperConstraint(
                                  constraintHeight: constraintHeight,
                                  percent: 15)),
                        )),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ));
        } else {
          
          if(

            (rootMap['topLeft'] == 'X' || rootMap['topLeft'] == 'O') && 
            (rootMap['topMid'] == 'X' || rootMap['topMid'] == 'O') && 
            (rootMap['topRight'] == 'X' || rootMap['topRight'] == 'O') && 

            (rootMap['midLeft'] == 'X' || rootMap['midLeft'] == 'O') && 
            (rootMap['midMid'] == 'X' || rootMap['midMid'] == 'O') && 
            (rootMap['midRight'] == 'X' || rootMap['midRight'] == 'O') && 

              (rootMap['bottomLeft'] == 'X' || rootMap['bottomLeft'] == 'O') && 
            (rootMap['bottomMid'] == 'X' || rootMap['bottomMid'] == 'O') && 
            (rootMap['bottomRight'] == 'X' || rootMap['bottomRight'] == 'O')  

          ){


   showDialog(
              context: context,
              barrierDismissible: false,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "It's A Tie",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProperConstraint(
                                constraintHeight: constraintHeight,
                                percent: 18)),
                      ),
                      SizedBox(
                          height: getProperConstraint(
                              constraintHeight: constraintHeight, percent: 10)),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            rootMap.forEach((k, v) {
                              switch (k) {
                                case 'topLeft':
                                  rootMap[k] = 'a';
                                  break;

                                case 'topMid':
                                  rootMap[k] = 'b';
                                  break;

                                case 'topRight':
                                  rootMap[k] = 'c';
                                  break;

                                case 'midLeft':
                                  rootMap[k] = 'd';
                                  break;
                                case 'midMid':
                                  rootMap[k] = 'e';
                                  break;
                                case 'midRight':
                                  rootMap[k] = 'f';
                                  break;

                                case 'bottomLeft':
                                  rootMap[k] = 'g';
                                  break;
                                case 'bottomMid':
                                  rootMap[k] = 'h';
                                  break;
                                case 'bottomRight':
                                  rootMap[k] = 'i';
                                  break;

                                default:
                                  break;
                              }
                            });
                          });

                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: getProperConstraint(
                                constraintHeight: constraintHeight, percent: 5),
                            vertical: getProperConstraint(
                                constraintHeight: constraintHeight,
                                percent: 8)),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                            child: Text(
                          "Play Again",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProperConstraint(
                                  constraintHeight: constraintHeight,
                                  percent: 15)),
                        )),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ));





          }

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //* Media Height
    double mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(0.01 * mediaHeight),
        padding: EdgeInsets.all(0.01 * mediaHeight),
        height: double.infinity,
        width: double.infinity,
        child: Column(children: <Widget>[
          Expanded(
              child: boxes(
                  mainFunction: mainFunction,
                  map: rootMap,
                  firstContainerItemKey: 'topLeft',
                  secondContainerItemKey: 'topMid',
                  thirdContainerItemKey: 'topRight')),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Expanded(
              child: boxes(
                  mainFunction: mainFunction,
                  map: rootMap,
                  firstContainerItemKey: 'midLeft',
                  secondContainerItemKey: 'midMid',
                  thirdContainerItemKey: 'midRight')),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Expanded(
              child: boxes(
                  mainFunction: mainFunction,
                  map: rootMap,
                  firstContainerItemKey: 'bottomLeft',
                  secondContainerItemKey: 'bottomMid',
                  thirdContainerItemKey: 'bottomRight'))
        ]),
      )),
    );
  }
}

Widget boxes(
    {@required Function mainFunction,
    @required Map<String, String> map,
    @required String firstContainerItemKey,
    @required String secondContainerItemKey,
    @required String thirdContainerItemKey}) {
  return LayoutBuilder(
    builder: (_, constraints) => Row(
      children: <Widget>[
        Expanded(
            child: InkWell(
          onTap: () => mainFunction(
              pressedKey: firstContainerItemKey,
              constraintHeight: constraints.constrainHeight()),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black))),
              child: Center(
                child: Text(
                  map[firstContainerItemKey] == "X" ||
                          map[firstContainerItemKey] == "O"
                      ? map[firstContainerItemKey]
                      : "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProperConstraint(
                          constraintHeight: constraints.constrainHeight(),
                          percent: 30)),
                ),
              )),
        )),
        Expanded(
            child: InkWell(
          onTap: () => mainFunction(
              pressedKey: secondContainerItemKey,
              constraintHeight: constraints.constrainHeight()),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black))),
              child: Center(
                child: Text(
                  map[secondContainerItemKey] == "X" ||
                          map[secondContainerItemKey] == "O"
                      ? map[secondContainerItemKey]
                      : "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProperConstraint(
                          constraintHeight: constraints.constrainHeight(),
                          percent: 30)),
                ),
              )),
        )),
        Expanded(
            child: InkWell(
          onTap: () => mainFunction(
              pressedKey: thirdContainerItemKey,
              constraintHeight: constraints.constrainHeight()),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.black))),
              child: Center(
                child: Text(
                  map[thirdContainerItemKey] == "X" ||
                          map[thirdContainerItemKey] == "O"
                      ? map[thirdContainerItemKey]
                      : "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProperConstraint(
                          constraintHeight: constraints.constrainHeight(),
                          percent: 30)),
                ),
              )),
        )),
      ],
    ),
  );
}

double getProperConstraint(
    {@required double constraintHeight, @required num percent}) {
  return (percent / 100) * constraintHeight;
}
