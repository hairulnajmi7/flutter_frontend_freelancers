import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/loginPage.dart';
import 'package:freelancer/menu.dart';
import 'package:freelancer/notification.dart';
import 'package:freelancer/search.dart';
import 'package:freelancer/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'api.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  // untuk input edit profile
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController confirmPwdController = new TextEditingController();

  Users user;
  Future<Users> _futureUsers;

  bool _isLoading = false;

  //untuk dapatkan data user untuk display
  void getUserData() async {
    //nak ambik data satu user

    var pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    var respond = await CallApi().getData("users/${id}");
    print(respond.body);

    if (respond.statusCode == 200) {
      //jika berjaya dia akan keluar data
      print(respond.body);
      print(respond.body);
      var data = json.decode(respond.body);

      setState(() {
        user = Users.fromJson(data);

        // overwrite dalam bentuk text
        fullNameController.text = user.fullname;
        usernameController.text = user.username;
        phoneController.text = user.phone;
        emailController.text = user.email;
        ageController.text = user.age.toString();
        pwdController.text = user.password;
      });
    }
  }

  Future<void> editUserData() async {
    var pref = await SharedPreferences.getInstance(); //to retrieve id user yg tgh login
    var id = pref.getString("id");

    var data = {
      'fullname': fullNameController.text,
      'username': usernameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'password': pwdController.text,
    };

    var respond = await CallApi().putData(data, "users/${id}");
    print(respond.body);

    if (respond.statusCode == 200) {
      print("Update Sucessfully");
      var data = json.decode(respond.body);
    }
  }

  @override
  initState() {
    // run function ini dulu
    super.initState();

    getUserData();
  }

  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Your Profile"),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs?.clear();
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage(),
                ));
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
                        height: MediaQuery.of(context).size.height / 1.28,
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
                          key: _editFormKey,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Edit Profile",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              30,
                                    ))
                              ],
                            ),
                            Container(
                              //                                height: MediaQuery.of(context).size.height/2,
                              //                                width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 40),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      //              height: MediaQuery.of(context).size.height/2,
                                      //                width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(top: 16),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.15,
                                            height: 35,
                                            padding: EdgeInsets.only(
                                                top: 4,
                                                left: 16,
                                                right: 16,
                                                bottom: 4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 5)
                                                ]),
                                            child: TextField(
                                              controller: fullNameController,
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.account_circle,
                                                    color: Colors.grey),
                                                hintText: 'Update Full Name',
                                                hintStyle:
                                                    TextStyle(fontSize: 15),
                                              ),
                                              // controller: fullNameController;
                                            ),
                                          ),
                                          Container(
                                              //              height: MediaQuery.of(context).size.height/2,
                                              //        width: MediaQuery.of(context).size.width,padding: EdgeInsets.only(top: 16),
                                              padding: EdgeInsets.only(top: 16),
                                              child: Column(children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.15,
                                                  height: 35,
                                                  padding: EdgeInsets.only(
                                                      top: 4,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            blurRadius: 5)
                                                      ]),
                                                  child: TextField(
                                                    controller:
                                                        usernameController,
                                                    decoration: InputDecoration(
                                                      icon: Icon(
                                                          Icons
                                                              .drive_file_rename_outline,
                                                          color: Colors.grey),
                                                      hintText: user.username,
                                                      hintStyle: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    // controller: usernameController;
                                                  ),
                                                )
                                              ])),
                                          Container(
                                              //              height: MediaQuery.of(context).size.height/2,
                                              //                width: MediaQuery.of(context).size.width,
                                              padding: EdgeInsets.only(top: 16),
                                              child: Column(children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.15,
                                                  height: 35,
                                                  padding: EdgeInsets.only(
                                                      top: 4,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            blurRadius: 5)
                                                      ]),
                                                  child: TextField(
                                                    controller: emailController,
                                                    decoration: InputDecoration(
                                                      icon: Icon(Icons.email,
                                                          color: Colors.grey),
                                                      hintText: 'Update Email',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    // controller: emailController;
                                                  ),
                                                )
                                              ])),
                                          Container(
                                              padding: EdgeInsets.only(top: 16),
                                              child: Column(children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.15,
                                                  height: 35,
                                                  padding: EdgeInsets.only(
                                                      top: 4,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            blurRadius: 5)
                                                      ]),
                                                  child: TextField(
                                                    controller: phoneController,
                                                    decoration: InputDecoration(
                                                      icon: Icon(
                                                          Icons.phone_rounded,
                                                          color: Colors.grey),
                                                      hintText:
                                                          'Update Number Phone',
                                                      hintStyle: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    // controller: phoneController;
                                                  ),
                                                ),
                                                Container(
                                                    //              height: MediaQuery.of(context).size.height/2,
                                                    //                width: MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.only(
                                                        top: 16),
                                                    child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.15,
                                                            height: 35,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4,
                                                                    left: 16,
                                                                    right: 16,
                                                                    bottom: 4),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius.circular(
                                                                            50)),
                                                                color: Colors.white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12,
                                                                      blurRadius:
                                                                          5)
                                                                ]),
                                                            child: TextField(
                                                              controller:
                                                                  pwdController,
                                                              decoration:
                                                                  InputDecoration(
                                                                icon: Icon(
                                                                    Icons
                                                                        .vpn_key,
                                                                    color: Colors
                                                                        .grey),
                                                                hintText:
                                                                    'Click to change password',
                                                                hintStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                Container(
                                                    //              height: MediaQuery.of(context).size.height/2,
                                                    //                width: MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.only(
                                                        top: 16),
                                                    child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.15,
                                                            height: 35,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4,
                                                                    left: 16,
                                                                    right: 16,
                                                                    bottom: 4),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius.circular(
                                                                            50)),
                                                                color: Colors.white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12,
                                                                      blurRadius:
                                                                          5)
                                                                ]),
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                icon: Icon(
                                                                    Icons
                                                                        .wifi_protected_setup,
                                                                    color: Colors
                                                                        .grey),
                                                                hintText:
                                                                    'Re-enter Password',
                                                                hintStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                            ),
                                                          )
                                                        ])),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 70.0,
                                                              left: 50,
                                                              right: 60),
                                                      child: Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFF00838F),
                                                                    Color(
                                                                        0xFF00838F)
                                                                  ],
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50))),
                                                        child: FlatButton(
                                                          child: Center(
                                                            child: Text(
                                                              'Cancel'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return EditProfilePage(); //link page
                                                            }));
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 70.0,
                                                              right: 20),
                                                      child: Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFF00838F),
                                                                    Color(
                                                                        0xFF00838F)
                                                                  ],
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50))),
                                                        child: FlatButton(
                                                          child: Center(
                                                            child: Text(
                                                              'Update'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            editUserData();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ])),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )),
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
                if (_currentIndex == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NotificationPage(); //link page
                  }));
                } else if (_currentIndex == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchPage();
                  }));
                } else if (_currentIndex == 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MenuPage();
                  }));
                }
              });
            }));
  }
}
