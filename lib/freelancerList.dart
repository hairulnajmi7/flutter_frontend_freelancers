import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';
import 'loginPage.dart';
import 'freelancers.dart';


class FreelancerListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FreelancerListState();
  }
}

class _FreelancerListState extends State<FreelancerListPage> {
  get page => null;

  Freelancers freelancer;
  List<Freelancers> freelancersList = [];

  Future<List<Freelancers>> _futureFreelancer;

  Future<List<Freelancers>> getUserData () async {

    var pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");
    var respond = await CallApi().getData ("freelancers");
    print(respond.body);

    if (respond.statusCode == 200) {

      print(respond.body);  //jika berjaya dia akan keluar data
      print(respond.body);

      var data = json.decode(respond.body);
      if(respond.statusCode==200){
        for(var u in data){
          setState(() {

            freelancer = Freelancers.fromJson(u);
            freelancersList.add(freelancer);
          });

        }

      }
      return freelancersList;
    }
  }

  Future<Freelancers> deleteUserData(id) async {

    var respond = await CallApi().deleteData("freelancers/${id}");
    print(respond.body);

    if (respond.statusCode == 200) {
      print("Delete Sucessfully");
      var data = json.decode(respond.body);
    }
  }

  @override
  initState() {
    super.initState();

    setState(() {
      _futureFreelancer =    getUserData();

    });
  }

  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: <Widget>[
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF00838F), //COLOR TOP
                              Color(0xFF00DEEA) //COLOR BOTTOM
                            ],
                          ),
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(90)))),
                ),
                Padding(
                  //size kotak dlm tu
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height / 1.1,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:20),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("List of Freelancers",
                                        style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.height / 30,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                  height: 550,
                                  width: MediaQuery.of(context).size.width*1,
                                  child: FutureBuilder(
                                      future: _futureFreelancer,
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {

                                        if (snapshot.data==null) {
                                          return Container (
                                              child: Center (
                                                  child: Text("Loading...")
                                              )
                                          );
                                        }
                                        else {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 0.5),
                                            child: ListView.builder(
                                                itemCount: snapshot.data.length,
                                                // ignore: missing_return
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return GestureDetector(
                                                      onTap: () {

                                                      },
                                                      child: Card(
                                                          child: Row
                                                            (children: <Widget> [
                                                            Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 335,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: <Widget> [
                                                                            Text(snapshot.data[index].name==null ? "Musibat" : snapshot.data[index].name) ,
                                                                            Text(snapshot.data[index].profession==null ? "Barua" : snapshot.data[index].profession),
                                                                          ]),
                                                                    ),
                                                                    Container(
                                                                      child:  IconButton(
                                                                        icon: Icon(Icons.delete),
                                                                        color: Colors.red,
                                                                        onPressed: () {
                                                                          deleteUserData(snapshot.data[index].id);
                                                                          setState(() {
                                                                          });
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                            )
                                                          ])));
                                                }),
                                          );
                                        }
                                      })),
                            ),
                          ],
                        ),
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
