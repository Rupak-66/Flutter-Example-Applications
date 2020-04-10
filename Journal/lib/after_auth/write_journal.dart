import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:journal/services/backend_service.dart';
import 'package:journal/services/internet_status.dart';

import 'package:provider/provider.dart';

class WriteJournal extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  WriteJournal({this.documentSnapshot});

  @override
  _WriteJournalState createState() => _WriteJournalState();
}

class _WriteJournalState extends State<WriteJournal> {
  bool _showSaveButton = false;
  String _initialControllerValue;

  int _controllerLength;

  TextEditingController _controller = TextEditingController();

  DateTime _now = DateTime.now();
  DateFormat _monthDayFormat = DateFormat.MMMd();
  DateFormat _timeFormat = DateFormat.jm();

  String _documentId;
  String _formattedDateTime;

  @override
  void initState() {
    super.initState();

    _formattedDateTime =
        "${_monthDayFormat.format(_now)} ${_timeFormat.format(_now)}";
    if (widget.documentSnapshot != null) {
      _documentId = widget.documentSnapshot.documentID;
      if (widget.documentSnapshot.data["content"] != null) {
        _controller.text = widget.documentSnapshot.data["content"];
      }
    }
    _initialControllerValue = _controller.text;
    _controllerLength = _controller.text.length;
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    BackendService _backendService = Provider.of<BackendService>(context);
    FirebaseUser _user = Provider.of<FirebaseUser>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (_controller.text.isNotEmpty &&
            _initialControllerValue != _controller.text) {
          if (await checkInternetConnection()) {
            _backendService.writeOrUpdateJournal(
                context: context,
                mediaHeight: mediaHeight,
                documentId: _documentId,
                content: _controller.text.trim(),
                user: _user,
                datetime: _formattedDateTime);
          } else {
            Fluttertoast.showToast(
                msg: "Connection Error !",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 18.0);
            Navigator.of(context).pop();
          }
        } else {
          Navigator.of(context).pop();
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                EvaIcons.arrowIosBackOutline,
                size: mediaHeight * .05,
              ),
              onPressed: () async {
                if (_controller.text.isNotEmpty &&
                    _initialControllerValue != _controller.text) {
                  if (await checkInternetConnection()) {
                    _backendService.writeOrUpdateJournal(
                        context: context,
                        mediaHeight: mediaHeight,
                        documentId: _documentId,
                        content: _controller.text.trim(),
                        user: _user,
                        datetime: _formattedDateTime);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Connection Error !",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white,
                        fontSize: 18.0);
                    Navigator.of(context).pop();
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              color: Theme.of(context).primaryColor,
            ),
            actions: <Widget>[
              IconButton(
                  tooltip: "share",
                  icon: Icon(
                    EvaIcons.shareOutline,
                    size: mediaHeight * .045,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: ()=> _backendService.shareJournal(journal: _controller.text.trim())),
              widget.documentSnapshot == null
                  ? Container()
                  : IconButton(
                      tooltip: "delete",
                      icon: Icon(
                        EvaIcons.trash2Outline,
                        size: mediaHeight * .045,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        if (await checkInternetConnection()) {
                          _backendService.deleteJournal(
                              documentId: _documentId,
                              user: _user,
                              context: context,
                              mediaHeight: mediaHeight);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Connection Error !",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        }
                      }),
              _showSaveButton
                  ? IconButton(
                      tooltip: "Save",
                      icon: Icon(
                        EvaIcons.saveOutline,
                        size: mediaHeight * .048,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        if (_controller.text.isNotEmpty &&
                            _initialControllerValue != _controller.text &&
                            await checkInternetConnection()) {
                          _backendService.writeOrUpdateJournal(
                              context: context,
                              mediaHeight: mediaHeight,
                              documentId: _documentId,
                              content: _controller.text.trim(),
                              user: _user,
                              datetime: _formattedDateTime);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Connection Error !",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        }
                      })
                  : Container()
            ],
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: buildExpandedTextField(mediaHeight, context),
        ),
      ),
    );
  }

  Padding buildExpandedTextField(double mediaHeight, BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaHeight * .03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: mediaHeight * .02,
            ),
            Text(
              "$_formattedDateTime | $_controllerLength characters",
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (val) {
                  setState(() {
                    _showSaveButton = val.isNotEmpty &&
                        _initialControllerValue != _controller.text;
                    _controllerLength = val.length;
                  });
                },
                autocorrect: false,
                cursorWidth: 1.5,
                decoration: InputDecoration(border: InputBorder.none),
                cursorColor: Theme.of(context).primaryColor,
                cursorRadius: Radius.circular(25.0),
                expands: true,
                maxLines: null,
                minLines: null,
              ),
            )
          ],
        ));
  }
}
