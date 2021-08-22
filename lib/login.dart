import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:be_safe/main.dart';
import 'package:latlong2/latlong.dart';

import 'package:gradient_text/gradient_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:be_safe/home.dart';

import 'signup.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneno = TextEditingController();

  savelocation() async {
    LocationData position = await location.getLocation();
    lat = position.latitude;
    long = position.longitude;
    print(position.latitude);
    setState(() {
      mytarget = LatLng(lat ?? 123213, long ?? 2312312);
    });
  }

  Location location = new Location();

  LatLng mytarget;

  double lat;
  double long;
  Location man = new Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    man.enableBackgroundMode(enable: true);

    savelocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4280228400),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/login1.png",
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text('Please signup to continue',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(4288914861))),
                        )),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            color: Color(4288914861), fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 2,
                      color: Color(4281937995),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(4281937995),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              color: Color(4288914861), fontSize: 18),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      elevation: 3,
                      color: Color(4281937995),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(4281937995)),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.vpn_key_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          auth
                              .signInWithEmailAndPassword(
                                  email: _email.text, password: _password.text)
                              .then((value) async {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        Maps(mytarget, value.user.uid)),
                                (route) => false);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 180,
                          child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                hexToColor("#1FA2FF"),
                                hexToColor("#12D8FA")
                              ])),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Signup()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dont have an account ?',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(4288914861))),
                        Text(' SignUp',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: hexToColor("#1FA2FF"))),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
