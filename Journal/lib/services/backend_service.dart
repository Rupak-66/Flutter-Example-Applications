import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class BackendService {
//* Share function

  void shareJournal({@required String journal}) {
    Share.share(journal);
  }

  //* This function will perform both write & update
  void writeOrUpdateJournal(
      {@required BuildContext context,
      @required double mediaHeight,
      @required FirebaseUser user,
      @required String content,
      @required String datetime,
      @required String documentId}) {
    try {
      if (user != null) {
        CollectionReference _collectionRef =
            Firestore.instance.collection(user.uid);
        showDialog(
            context: context,
            builder: (_) =>
                _loadingDialog(context: _, mediaHeight: mediaHeight));

        _collectionRef
            .document(documentId)
            .setData({
              "content": content,
              "date & time": datetime,
            })
            .timeout(Duration(seconds: 4),
                onTimeout: () => Fluttertoast.showToast(
                    msg: "Connection Error !",
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 18.0))
            .then((val) async {
              Navigator.of(context).pop();

              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      print("Exception from writeJournal function: $e");
    }
  }

//* This function performs delete
  void deleteJournal(
      {@required String documentId,
      @required FirebaseUser user,
      @required BuildContext context,
      double mediaHeight}) async {
    try {
      CollectionReference _collectionRef =
          Firestore.instance.collection(user.uid);

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                title: Text("Are you Sure?",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: mediaHeight * 0.05)),
                content: SingleChildScrollView(
                  child: Text(
                    "You will not be able to recover this journal!",
                    style: TextStyle(fontSize: mediaHeight * 0.029),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => _loadingDialog(
                                context: context, mediaHeight: mediaHeight));
                        _collectionRef
                            .document(documentId)
                            .delete()
                            .timeout(Duration(seconds: 4),
                                onTimeout: () => Fluttertoast.showToast(
                                    msg: "Connection Error !",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.redAccent,
                                    textColor: Colors.white,
                                    fontSize: 18.0))
                            .then((val) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: mediaHeight * 0.03),
                      )),
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: mediaHeight * 0.03),
                      ))
                ],
              ));
    } catch (e) {
      print("Exception from deleteJournal function: $e");
    }
  }

  AlertDialog _loadingDialog(
      {@required BuildContext context, @required mediaHeight}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      titlePadding:
          EdgeInsets.symmetric(horizontal: 0.0, vertical: mediaHeight * .1),
      title: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
