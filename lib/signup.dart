import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer/users.dart';
import 'api.dart';
import 'loginPage.dart';

Future<Users> createUsers(String fullname, username, phone, email, age, password ) async {

  //semua data dalam satu variable
  var data={
    'fullname': fullname,
    'username' : username,
    'phone' : phone,
    'email' : email,
    'age' : age,
    'password' : password,
    'role' : "user"
  };
  var response  = await CallApi().postData(data,"users");
  print(response.statusCode);

  if (response.statusCode == 200) {
    print("It's working huhu") ; } else {
    throw Exception('Failed to create User');
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {

  //untuk input data sign up
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = new TextEditingController();
  TextEditingController usernameController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController ageController= new TextEditingController();
  TextEditingController pwdController= new TextEditingController();
  TextEditingController confirmPwdController= new TextEditingController();
  bool _isLoading = false;

@override
//inistate untuk permulaan state
  void iniState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Stack(children: [
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
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height / 1.15,
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
                          child: Form (
                            key: _signupFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Register",
                                        style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.height / 30,
                                        ))
                                  ],
                                ),
                                Container(
                                  //   height: MediaQuery.of(context).size.height/2,
                                  //   width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(top: 40),
                                    child: Column(children: <Widget>[

                                      Container(
                                        width: MediaQuery.of(context).size.width / 1.2,
                                        height: 35,
                                        padding: EdgeInsets.only(
                                            top: 4, left: 16, right: 16, bottom: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(50)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12, blurRadius: 5)
                                            ]),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.credit_card_outlined,
                                                color: Colors.grey),
                                            hintText: 'Full Name',
                                            hintStyle: TextStyle(fontSize: 15),
                                          ),
                                          controller: fullNameController,
                                          // ignore: missing_return
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Please insert your full name.";
                                            }
                                          }
                                          // validator: (value) {
                                          //   if (value.length < 3) {
                                          //     return "Please enter your full name.";
                                          //   }
                                          // },
                                        ),
                                      )
                                    ])),
                                Container(
                                  //   height: MediaQuery.of(context).size.height/2,
                                  //   width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(top: 16),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width / 1.2,
                                          height: 35,
                                          padding: EdgeInsets.only(
                                              top: 4, left: 16, right: 16, bottom: 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(50)),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12, blurRadius: 5)
                                              ]),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.drive_file_rename_outline,
                                                  color: Colors.grey),
                                              hintText: 'Username',
                                              hintStyle: TextStyle(fontSize: 15),
                                            ),
                                            controller: usernameController,
                                              // ignore: missing_return
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Please insert your user name.";
                                                }
                                              }
                                            ),
                                        ),
                                        Container(
                                          //  height: MediaQuery.of(context).size.height/2,
                                          //  width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.only(top: 16),
                                            child: Column(children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 1.2,
                                                height: 35,
                                                padding: EdgeInsets.only(
                                                    top: 4, left: 16, right: 16,
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
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.phone_rounded,
                                                        color: Colors.grey),
                                                    hintText: 'No. Phone',
                                                    hintStyle: TextStyle(fontSize: 15),
                                                  ),
                                                  controller: phoneController,
                                                    // ignore: missing_return
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return "Please insert your phone number.";
                                                      }
                                                    }
                                                ),
                                              )
                                            ])),
                                        Container(
                                          //  height: MediaQuery.of(context).size.height/2,
                                          //  width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.only(top: 16),
                                            child: Column(children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 1.2,
                                                height: 35,
                                                padding: EdgeInsets.only(
                                                    top: 4, left: 16, right: 16,
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
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.email,
                                                        color: Colors.grey),
                                                    hintText: 'Email',
                                                    hintStyle: TextStyle(fontSize: 15),
                                                  ),
                                                  controller: emailController,
                                                  keyboardType: TextInputType.emailAddress,
                                                  validator: emailValidator,
                                                ),
                                              )
                                            ])),
                                        Container(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Column(children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 1.2,
                                                height: 35,
                                                padding: EdgeInsets.only(
                                                    top: 4, left: 16, right: 16,
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
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.calendar_today_rounded,
                                                        color: Colors.grey),
                                                    hintText: 'Age',
                                                    hintStyle: TextStyle(fontSize: 15),
                                                  ),
                                                  controller: ageController,
                                                    // ignore: missing_return
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return "Please insert your age.";
                                                      }
                                                    }
                                                ),
                                              ),
                                              Container(
                                                // height: MediaQuery.of(context).size.height/2,
                                                // width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.only(top: 16),
                                                  child: Column(children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context)
                                                          .size.width / 1.2,
                                                      height: 35,
                                                      padding: EdgeInsets.only(
                                                          top: 4, left: 16, right: 16, bottom: 4
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(50)),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.black12,
                                                                blurRadius: 5)
                                                          ]),
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                          icon: Icon(Icons.vpn_key,
                                                              color: Colors.grey),
                                                          hintText: 'Password',
                                                          hintStyle: TextStyle(fontSize: 15),
                                                        ),
                                                        controller: pwdController,
                                                        validator: pwdValidator,
                                                      ),
                                                    )
                                                  ])),
                                              Container(
                                                //              height: MediaQuery.of(context).size.height/2,
                                                //                width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.only(top: 16),
                                                  child: Column(children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width / 1.2,
                                                      height: 35,
                                                      padding: EdgeInsets.only(
                                                          top: 4, left: 16, right: 16, bottom: 4
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(50)),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.black12,
                                                                blurRadius: 5)
                                                          ]),
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                          icon: Icon(
                                                              Icons.wifi_protected_setup,
                                                              color: Colors.grey),
                                                          hintText: 'Re-enter Password',
                                                          hintStyle: TextStyle(fontSize: 15),
                                                        ),
                                                        controller: confirmPwdController,
                                                        validator: pwdValidator,
                                                      ),
                                                    )
                                                  ])),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 70.0, left: 50, right: 60),
                                                    child: Container(
                                                      height: 50,
                                                      width: MediaQuery.of(context).size.width / 3.5,
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Color(0xFF00838F),
                                                              Color(0xFF00838F)
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(50))),
                                                      child: FlatButton(
                                                        child: Center(
                                                          child: Text(
                                                            'Back'.toUpperCase(),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(context,
                                                              MaterialPageRoute(
                                                                  builder: (context) {
                                                                    return LoginPage(); //link page
                                                                  }));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 70.0, left: 0, right: 0),
                                                    child: Container(
                                                      height: 50,
                                                      width: MediaQuery.of(context).size.width / 3.5,
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Color(0xFF00838F),
                                                              Color(0xFF00838F)
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(50))),
                                                      child: FlatButton(
                                                          child: Center(
                                                            child: Text(
                                                              _isLoading ? 'Submitting' : 'Submit'.toUpperCase(),
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {       //untuk update state frontend
                                                              _isLoading = true;
                                                                createUsers(    //dia akan create user jika process submit is successfull
                                                                fullNameController.text,
                                                                usernameController.text,
                                                                phoneController.text,
                                                                emailController.text,
                                                                ageController.text,
                                                                pwdController.text);
                                                            }
                                                            );
                                                          }
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
                          )
                ),
              ],
            ))
      ])
    ])
          )));
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 7) {
      return 'Password must be longer than 7 characters';
    } else {
      return null;
    }
  }
}
