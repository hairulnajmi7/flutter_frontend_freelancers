import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/constant.dart';
import 'package:freelancer/homeAdmin.dart';
import 'package:freelancer/signup.dart';
import 'package:freelancer/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'menu.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var email, password;

  Future<Users> _futureJwt;

  //To get the email and password data fro the field
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController pwdController = new TextEditingController();

  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                    padding: const EdgeInsets.only(top: 150.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height / 1.42,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[ 
                                    Text("Login",
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height / 30,
                                        ))
                                  ],
                                ),
                                _buildEmailRow(),
                                _buildPasswordRow(),
                                _buildForgetPasswordButton(),
                                _buildLoginButton(emailController.text, pwdController.text),
                                _buildOrRow(),
                                _buildSignUpButton(context),
                      ],
                    )),
              ],
            ),
          ),
        ],
      )
    ])));
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: emailController,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'Email'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: pwdController,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  void createLoginPageState(context,String email, password ) async {

    final http.Response response = await http.post(
        'http://192.168.43.170:5000/api/auth/login/',  //api
        headers: <String, String> {
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
        });

    SharedPreferences logindata;
    var data = json.decode(response.body);
    logindata = await SharedPreferences.getInstance();

    setState(() {
      print(response.body);
      logindata.setString("id",data["id"].toString());
    }

    );

    if (response.statusCode == 200) {

      if (data["role"] == "user") {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      }

      else if (data["role"] == "admin") {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeAdminPage()),
        );
      }

    }

  }

  Widget _buildLoginButton(a,b) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Container(
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 15),
            margin: EdgeInsets.only(bottom: 20),
            child: RaisedButton(
              elevation: 5.0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                setState((){
                });
              createLoginPageState(context,a,b);

              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: MediaQuery.of(context).size.height / 40,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget _buildForgetPasswordButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      FlatButton(
        onPressed: () {},
        child: Text("Forgot Password ?"),
      ),
    ],
  );
}

Widget _buildOrRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        '- OR -',
      )
    ],
  );
}

Widget _buildSignUpButton(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(17.0),
        child: Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 15),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUpPage(); //link page
              }));
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
