import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/editprofile.dart';
import 'package:freelancer/menu.dart';
import 'package:freelancer/notification.dart';


class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchPage> {
  get page => null;

  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  int _currentIndex = 1;

  final tabs = [
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Notification")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Search Page"),
          backgroundColor: Colors.cyan,
          actions: <Widget> [
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.search),
            )
          ]
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Categories",
                                        style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.height / 30,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ])),

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: ('Home'),
                  backgroundColor: Colors.cyan),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: ('Search'),
                  backgroundColor: Colors.cyan),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: ('Notification'),
                  backgroundColor: Colors.cyan),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: ('Profile'),
                backgroundColor: Colors.cyan,
              )
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (_currentIndex == 3) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditProfilePage(); //link page
                  }));
                }
                else if (_currentIndex == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotificationPage();
                  }));
                }
                else if (_currentIndex == 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MenuPage();
                  }));
                }
              });
            }));
  }
}

class SearchBar {
}

