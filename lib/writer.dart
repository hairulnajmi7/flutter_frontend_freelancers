import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class WriterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WriterPageState();
  }
}

class _WriterPageState extends State<WriterPage> {
  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Writer"),
        backgroundColor: Colors.redAccent,
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
