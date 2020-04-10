import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal/Widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  static List<DocumentSnapshot> _documentSnapshots = [];

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    FirebaseUser _user = Provider.of<FirebaseUser>(context);

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'NOTES',
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: JournalSearch(
                            mediaHeight: MediaQuery.of(context).size.height));
                  })
            ]),
        floatingActionButton: FloatingActionButton(
          tooltip: "write journal",
          onPressed: () => Navigator.of(context).pushNamed("WriteJournal"),
          child: Icon(Icons.create),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: CustomDrawer(),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.fromLTRB(mediaHeight * .01,
                    mediaHeight * .02, mediaHeight * .01, 0.0),
                child: StreamBuilder(
                    stream:
                        Firestore.instance.collection(_user.uid).snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        print(
                            "The exception via reading data : ${snapshot.error}");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return loadingSpinKit(context);
                          break;
                        default:
                          if (!snapshot.data.documents.isEmpty) {
                            _documentSnapshots = snapshot.data.documents;
                            return StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                    "WriteJournal",
                                    arguments: snapshot.data.documents[index]),
                                child: journalCard(
                                    mediaHeight, snapshot, index, context),
                              ),
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.fit(2),
                            );
                          }
                          return emptyJournal(mediaHeight, context);
                      }
                    }))));
  }

  Center loadingSpinKit(BuildContext context) {
    return Center(
      child: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ),
      ),
    );
  }

  Card journalCard(double mediaHeight, AsyncSnapshot snapshot, int index,
      BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      elevation: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaHeight * .015, vertical: mediaHeight * .02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //* Title
            Text(snapshot.data.documents[index]["content"].toUpperCase(),
                maxLines: 2,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: mediaHeight * .026)),
            SizedBox(
              height: mediaHeight * .015,
            ),
            //* Summary
            Text(
              snapshot.data.documents[index]["content"],
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54, fontSize: mediaHeight * .025),
            ),
            SizedBox(
              height: mediaHeight * .015,
            ),
            //* Date
            Text(snapshot.data.documents[index]["date & time"],
                maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: mediaHeight * .025))
          ],
        ),
      ),
    );
  }

  Center emptyJournal(double mediaHeight, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: mediaHeight * .005, horizontal: mediaHeight * .002),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset("assets/addnotes.svg", height: mediaHeight * .35),
            SizedBox(
              height: mediaHeight * .04,
            ),
            Text("Empty Journal",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Title",
                    fontSize: mediaHeight * 0.06))
          ],
        ),
      )),
    );
  }
}

class JournalSearch extends SearchDelegate {
  double mediaHeight;
  JournalSearch({this.mediaHeight});
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.close), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DocumentSnapshot> queryContainedList = _NotesState._documentSnapshots
        .where((snap) => snap["content"].toLowerCase().contains(query))
        .toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(
          mediaHeight * .01, mediaHeight * .02, mediaHeight * .01, 0.0),
      child: query.isEmpty
          ? Center(
              child: Text("Searching...",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: mediaHeight * 0.035)))
          : queryContainedList.length == 0
              ? Center(
                  child: Text("No Found",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: mediaHeight * 0.035)))
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: queryContainedList.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      close(context, null);
                      Navigator.of(context).pushNamed("WriteJournal",
                          arguments: queryContainedList[index]);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      elevation: 1.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaHeight * .015,
                            vertical: mediaHeight * .02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //* Title
                            Text(
                                queryContainedList[index]["content"]
                                    .toUpperCase(),
                                maxLines: 2,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: mediaHeight * .026)),
                            SizedBox(
                              height: mediaHeight * .015,
                            ),
                            //* Summary
                            Text(
                              queryContainedList[index]["content"],
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: mediaHeight * .025),
                            ),
                            SizedBox(
                              height: mediaHeight * .015,
                            ),
                            //* Date
                            Text(queryContainedList[index]["date & time"],
                                maxLines: 1,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: mediaHeight * .025))
                          ],
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                ),
    );
  }
}
