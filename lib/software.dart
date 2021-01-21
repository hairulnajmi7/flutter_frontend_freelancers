import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SoftwarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SoftwarePageState();
  }
}

class _SoftwarePageState extends State<SoftwarePage> {
  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Software Developer"),
          backgroundColor: Colors.blueAccent,
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
