import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SalesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalesPageState();
  }
}

class _SalesPageState extends State<SalesPage> {
  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Sales in Marketing"),
        backgroundColor: Colors.greenAccent,
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
