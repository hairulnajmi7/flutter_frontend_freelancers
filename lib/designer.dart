import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DesignerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DesignerPageState();
  }
}

class _DesignerPageState extends State<DesignerPage> {
  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Designer"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
          child: Column(children: <Widget>[
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                  ],
                ),
              ],)
          ])),
    );
  }
}
