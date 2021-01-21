import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RatingPageState();
  }
}

class _RatingPageState extends State<RatingPage> {
  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Give Rates", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellowAccent,
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
                        padding: const EdgeInsets.only(top: 170),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Rate this freelancer",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 30,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Container(
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(top :50.0),
                         child: Container(
                           height: 40,
                           width: 180,
                           child: RaisedButton(
                             onPressed: () {

                             },
                            color: Colors
                                .blue[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius
                                  .circular(
                                  20.0),
                            ),
                            child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors
                                        .white)),
                      ),
                         ),
                       )
                    ],
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
