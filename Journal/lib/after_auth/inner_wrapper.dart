import 'package:flutter/material.dart';
import 'package:journal/Widgets/drawer_item_selector.dart';
import 'package:journal/after_auth/about.dart';
import 'package:journal/after_auth/notes.dart';
import 'package:journal/after_auth/trash.dart';
import 'package:provider/provider.dart';


class InnerWrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerItemSelector>(

      builder: (_, provider,__){
        if(provider.buttonName == "Notes"){
          return Notes();
        }
        else if(provider.buttonName == "Trash"){

          return Trash();

        }
        return About();
      }

    );
  }
}