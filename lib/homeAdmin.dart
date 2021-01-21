import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/userList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'freelancerList.dart';
import 'loginPage.dart';

class HomeAdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeAdminState();
  }
}

class _HomeAdminState extends State<HomeAdminPage> {
  get page => null;

  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: new AppBar(
        title: new Text("Welcome !"),
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.clear();
              Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage(),
                  )
              );
            },
          )
        ],
      ),
        body: Container(
            child: Column(children: <Widget>[
              Stack(
                children: [
                  Padding(
                    //size kotak dlm tu
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height / 1.17,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // lekuk kotak
                              boxShadow: [
                                BoxShadow(
                                  //bayang kotak
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 9,
                                    spreadRadius: 3)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget> [
                              RaisedButton(
                                child: Text("Users"),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return UserListPage(); //link page
                                  }));
                                },
                              ),
                              Column(
                                children: [
                                  RaisedButton(
                                    child: Text("Freelancers"),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return FreelancerListPage(); //link page
                                      }));
                                    },
                                  ),
                                ],
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ])),
    );
  }
}
