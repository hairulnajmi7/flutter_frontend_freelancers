import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/editprofile.dart';
import 'package:freelancer/sales.dart';
import 'package:freelancer/search.dart';
import 'package:freelancer/software.dart';
import 'package:freelancer/users.dart';
import 'package:freelancer/writer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';
import 'designer.dart';
import 'freelancers.dart';
import 'hires.dart';
import 'notification.dart';

Future<Hires> createHires (String users, id ) async {

  var pref = await SharedPreferences.getInstance();
  var users = pref.getString("id");
  //semua data dalam satu variable
  var data= {
    'freelancerid' : id,
    'userid' : users,

  };

  var response  = await CallApi().postData(data,"hires");
  print(response.statusCode);

  if (response.statusCode == 200) {
    print("It's working huhu") ; } else {
    throw Exception('Failed to create hire');
  }
}

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {
  get page => null;

  Freelancers freelancer; //data freelancer dalam bentuk json
  List<Freelancers> freelancersList = []; //data freelancer dalam bentuk json dalam array
  Future<List<Freelancers>> _futureFreelancer;
  Future<Hires> futureHires;

  //dapatkan data list of freelancers
  Future<List<Freelancers>> getFreelancerData() async {
    var pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    var respond = await CallApi().getData("freelancers");
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
      _futureFreelancer = getFreelancerData();
    });
  }

  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  int _currentIndex = 0;

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
          title: new Text("Welcome "),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
            child: Column(
                children: <Widget>[
              Stack(
                children: [
                  Padding(
                    //size kotak dlm tu
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Categories",
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
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 20),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 20),
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0
                                                  )
                                              )
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                            return SoftwarePage(); //link page
                                                          }));
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Software Developer",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "20 Items",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 20),
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.amberAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                            return DesignerPage(); //link page
                                                          }));
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Designer",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "20 Items",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 20),
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                            return SalesPage(); //link page
                                                          }));
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Sales",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "20 Items",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 20),
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                            return WriterPage(); //link page
                                                          }));
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Writer",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "20 Items",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Available Freelancers",
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
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 13),
                                        child: Container(
                                            height: 322,
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
                                                                                      // Text(
                                                                                      //     snapshot
                                                                                      //         .data[index]
                                                                                      //         .id.toString() ==
                                                                                      //         null
                                                                                      //         ? "Cibai"
                                                                                      //         : snapshot
                                                                                      //         .data[index]
                                                                                      //         .id.toString(),
                                                                                      //     style: TextStyle(
                                                                                      //         color: Colors
                                                                                      //             .black)),
                                                                                      Text(
                                                                                          snapshot
                                                                                              .data[index]
                                                                                              .name ==
                                                                                              null
                                                                                              ? "Unkown name"
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
                                                                                              ? "Unkmown completedProject"
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
                                                                            child: FlatButton(
                                                                              onPressed: () async {
                                                                              setState(() {
                                                                                futureHires = createHires(
                                                                                    users.toString(),
                                                                                  snapshot.data[index].id.toString(),
                                                                                );
                                                                              });
                                                                                },
                                                                              color: Colors
                                                                                  .green[200],
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    20.0),
                                                                              ),
                                                                              child: Text(
                                                                                  "Hire",
                                                                                  style: TextStyle(
                                                                                      color: Colors
                                                                                          .white)),
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
                        ],
                      )
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
                } else if (_currentIndex == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotificationPage();
                  }));
                } else if (_currentIndex == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage();
                  }));
                }
              });
            }));
  }

}