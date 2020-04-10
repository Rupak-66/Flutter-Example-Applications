import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'drawer_item_selector.dart';


class CustomDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AuthService _authServiceProvider = Provider.of<AuthService>(context);
    FirebaseUser _user = Provider.of<FirebaseUser>(context);
    double mediaHeight = MediaQuery.of(context).size.height;
    return Consumer<DrawerItemSelector>(
      builder: (_, _drawerItemSelectorProvider, __) => Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                otherAccountsPictures: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close,
                        color: Colors.white, size: mediaHeight * .045),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                      child: Text(
                          _user == null
                              ? ""
                              : _user.displayName != null
                                  ? _user.displayName[0]
                                  : _user.email[0],
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: mediaHeight * .07))),
                ),
                accountName: Text(_user != null
                    ? _user.displayName != null
                        ? _user.displayName
                        : _user.email
                            .substring(0, _user.email.indexOf("@"))
                    : ""),
                accountEmail: Text(_user != null
                    ? _user.email != null ? _user.email : ""
                    : "")),
            DrawerItems(
                textColor: _drawerItemSelectorProvider.notesButtonColor,
                
                buttonName: "Notes",
                buttonHighLightColor:
                    _drawerItemSelectorProvider.notesButtonHighLightColor,
                buttonIcon: Icon(Icons.library_books,
                    size: mediaHeight * 0.04,
                    color: _drawerItemSelectorProvider.notesButtonColor)),
            SizedBox(
              height:mediaHeight * 0.005,
            ),
            DrawerItems(
                textColor: _drawerItemSelectorProvider.trashButtonColor,
               
                buttonName: "Trash",
                buttonHighLightColor:
                    _drawerItemSelectorProvider.trashButtonHighLightColor,
                buttonIcon: Icon(EvaIcons.trash2Outline,
                    size:mediaHeight * 0.043,
                    color: _drawerItemSelectorProvider.trashButtonColor)),
            SizedBox(
              height: mediaHeight * 0.005,
            ),
            DrawerItems(
                textColor: _drawerItemSelectorProvider.aboutButtonColor,
              
                buttonName: "About",
                buttonHighLightColor:
                    _drawerItemSelectorProvider.aboutButtonHighLightColor,
                buttonIcon: Icon(Icons.help_outline,
                    size: mediaHeight * 0.043,
                    color: _drawerItemSelectorProvider.aboutButtonColor)),
            Divider(),
            SizedBox(
              height: mediaHeight * 0.005,
            ),
            ListTile(
              onTap: () => _authServiceProvider.signOut(),
              leading: Icon(Icons.exit_to_app,
                  size:mediaHeight * 0.04,
                  color: Theme.of(context).primaryColor),
              title: Text("Logout",
                  style: TextStyle(fontSize: mediaHeight * .029)),
            ),
            SizedBox(height: mediaHeight * .02)
          ],
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  final String buttonName;
  final Color buttonHighLightColor;
  final Icon buttonIcon;
  final Color textColor;
  DrawerItems(
      {@required this.buttonName,
      @required this.buttonHighLightColor,
      @required this.textColor,
      @required this.buttonIcon,
      });

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    DrawerItemSelector _drawerItemSelectorProvider =
        Provider.of<DrawerItemSelector>(context, listen: false);
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10.0),
      child: InkWell(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
          splashColor: Colors.blueGrey,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
              color: buttonHighLightColor,
            ),
            width: double.infinity,
            child: ListTile(
              leading: buttonIcon,
              title: Text(buttonName,
                  style: TextStyle(
                      fontSize: mediaHeight * .027, color: textColor)),
            ),
          ),
          onTap: () {
            switch (buttonName) {
              case "Notes":
                _drawerItemSelectorProvider.changeButtonColor(
                    buttonName: buttonName);
                    Navigator.of(context).pushReplacementNamed("Notes");
                break;
              case "Trash":
                _drawerItemSelectorProvider.changeButtonColor(
                    buttonName: buttonName);
                    Navigator.of(context).pushReplacementNamed("Trash");
                break;

              case "About":
                _drawerItemSelectorProvider.changeButtonColor(
                    buttonName: buttonName);
                   Navigator.of(context).pushReplacementNamed("About");
                break;
            }
          }),
    );
  }
}
