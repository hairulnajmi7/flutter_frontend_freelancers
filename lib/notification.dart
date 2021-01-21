import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/menu.dart';
import 'package:freelancer/rating.dart';
import 'package:freelancer/search.dart';
import 'package:freelancer/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';
import 'editprofile.dart';
import 'freelancers.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {


  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  Freelancers freelancer;
  List<Freelancers> freelancersList = [];
  Future<List<Freelancers>> _futureFreelancer;


  Future<List<Freelancers>> getHires() async {
    var pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    var respond = await CallApi().getData("hires");
    print(respond.body);

    if (respond.statusCode == 200) {
      print(respond.body); //jika berjaya dia akan keluar data
      print(respond.body);

      var data = json.decode(respond.body);
      if (respond.statusCode == 200) {
        for (var u in data) {
          setState(() {
            freelancer = Freelancers.fromJson(u);
            freelancersList.add(freelancer);
          });
        }
      }
      return freelancersList;
    }
  }

  var currentUser;
  Future<Users> users() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    final response = await CallApi().getData("users/${id}");
    if (response.statusCode == 200) {

      Users user;

      var values = json.decode(response.body);
      print(values);
      setState(() {
        currentUser = Users.fromJson(values);
      });
      return user;
    }

    else {
      throw Exception('Failed to load server');
    }
  }

  @override
  initState() {
    super.initState();

    setState(() {
      _futureFreelancer = getHires();
    });
  }

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Notification"),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
            child: Column(
                children: <Widget>[
              Stack(
                children: [
                    Padding (
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                           Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("Hired Freelancers",
                                      style: TextStyle(
                                        fontSize:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height / 38,
                                      ))
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                        height: 535,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 1,
                                        child: FutureBuilder(
                                            future: _futureFreelancer,
                                            // ignore: missing_return
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.data == null) {
                                                return Container(
                                                    child: Center(
                                                        child: Text(
                                                            "Loading...")));
                                              }
                                              else {
                                                return Padding(
                                                    padding: const EdgeInsets
                                                        .only(top: 0.5),
                                                    child: ListView.builder(
                                                        itemCount: snapshot
                                                            .data.length,
                                                        // ignore: missing_return
                                                        itemBuilder: (
                                                            BuildContext context,
                                                            int index) {
                                                          return Card(
                                                            elevation: 5.0,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  10),
                                                            ),
                                                            child: Container(
                                                                width: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal: 10.0,
                                                                    vertical: 10.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                              width: 60.0,
                                                                              height: 55.0,
                                                                              color: Colors
                                                                                  .white,
                                                                              child: CircleAvatar(
                                                                                backgroundImage: NetworkImage(
                                                                                    snapshot
                                                                                        .data[index]
                                                                                        .image ==
                                                                                        null
                                                                                        ? "https://3.bp.blogspot.com/-qDc5kIFIhb8/UoJEpGN9DmI/AAAAAAABl1s/BfP6FcBY1R8/s1600/BlueHead.jpge"
                                                                                        : snapshot
                                                                                        .data[index]
                                                                                        .image),
                                                                              )
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5.0
                                                                          ),
                                                                          Container(
                                                                            width: 150,
                                                                            child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment
                                                                                    .start,
                                                                                children: <
                                                                                    Widget>[
                                                                                  Text(
                                                                                      snapshot
                                                                                          .data[index]
                                                                                          .name ==
                                                                                          null
                                                                                          ? "Unknown name"
                                                                                          : snapshot
                                                                                          .data[index]
                                                                                          .name,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .black)),
                                                                                  Text(
                                                                                      snapshot
                                                                                          .data[index]
                                                                                          .profession ==
                                                                                          null
                                                                                          ? "Unknown profession"
                                                                                          : snapshot
                                                                                          .data[index]
                                                                                          .profession,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .blue)),
                                                                                  Text(
                                                                                      snapshot
                                                                                          .data[index]
                                                                                          .completedProject ==
                                                                                          null
                                                                                          ? "Unknown completedProject"
                                                                                          : snapshot
                                                                                          .data[index]
                                                                                          .completedProject,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .red)),
                                                                                  Text(
                                                                                      snapshot
                                                                                          .data[index]
                                                                                          .experience ==
                                                                                          null
                                                                                          ? "Unknown experience"
                                                                                          : snapshot
                                                                                          .data[index]
                                                                                          .experience,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .deepOrange)),
                                                                                  Text(
                                                                                      snapshot
                                                                                          .data[index]
                                                                                          .hourlyRate ==
                                                                                          null
                                                                                          ? "Unknown hourlyRate"
                                                                                          : snapshot
                                                                                          .data[index]
                                                                                          .hourlyRate,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .blueGrey)),
                                                                                  Text(
                                                                                      snapshot
                                                                                          .data[index]
                                                                                          .country ==
                                                                                          null
                                                                                          ? "Unknown country"
                                                                                          : snapshot
                                                                                          .data[index]
                                                                                          .country,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .green)),
                                                                                ]
                                                                            ),
                                                                          )
                                                                        ]
                                                                    ),
                                                                    Container(
                                                                        width: 100,
                                                                        alignment: Alignment
                                                                            .center,
                                                                        padding: EdgeInsets
                                                                            .symmetric(
                                                                            horizontal: 10.0,
                                                                            vertical: 10.0),
                                                                        child: Column(
                                                                          children: [
                                                                            FlatButton(
                                                                              onPressed: () async {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                  return RatingPage(); //link page
                                                                                }));
                                                                              },
                                                                              color: Colors
                                                                                  .yellowAccent[200],
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    20.0),
                                                                              ),
                                                                              child: Text(
                                                                                  "Rate",
                                                                                  style: TextStyle(
                                                                                      color: Colors
                                                                                          .black)),
                                                                            ),
                                                                            FlatButton(
                                                                              onPressed: () async {
                                                                              
                                                                              },
                                                                              color: Colors
                                                                                  .green,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    20.0),
                                                                              ),
                                                                              child: Text(
                                                                                  "Call",
                                                                                  style: TextStyle(
                                                                                      color: Colors
                                                                                          .black)),
                                                                            ),
                                                                          ],
                                                                        )
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                          );
                                                        }
                                                    )
                                                );
                                              }
                                            }
                                        )
                                    )
                                )
                              ]
                          )
                        ],
                      ),
                    ),
                  ),
                ],)
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
                else if (_currentIndex == 1 ) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage();
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
