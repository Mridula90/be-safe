import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:be_safe/main.dart';
import 'package:gradient_text/gradient_text.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:be_safe/home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savelocation();
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber);
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _phoneno = TextEditingController(text: mobileNumber);
    });
  }

  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4280228400),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 40, left: 30),
                child:
                    // Text('Login',
                    //     style: GoogleFonts.poppins(
                    //         fontSize: 40,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black87)),
                    Align(
                  alignment: Alignment.topLeft,
                  child: Text("Create Account",
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )),
            // Align(
            //     alignment: Alignment.topLeft,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 30),
            //       child: Text('Please signup to continue',
            //           style: GoogleFonts.poppins(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 15,
            //               color: Color(4288914861))),
            //     )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                        'Name',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            color: Color(4288914861), fontSize: 18),
                      ),
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
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12,
                        //     blurRadius: 6.0,
                        //     offset: Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: Stack(
                        children: [
                          TextFormField(
                              controller: _name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Color(4288914861)),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(Icons.person_outline,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email',
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
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        controller: _email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                      ),
                      child: TextFormField(
                        controller: _password,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Age',
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
                      ),
                      child: TextFormField(
                        controller: _age,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.date_range_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Phone Number',
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
                      ),
                      child: TextFormField(
                        controller: _phoneno,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Profile Photo',
                        style:
                            TextStyle(color: Color(4288914861), fontSize: 18),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedimage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (pickedimage != null) {
                        setState(() {
                          image = File(pickedimage.path);
                        });
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(4281937995)),
                        child: image == null
                            ? Icon(
                                Icons.upload_file,
                                color: Colors.white,
                                size: 100,
                              )
                            : Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(image),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                              )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        String imgurl;

                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('${DateTime.now()}user_image');

                        await ref.putFile(image).onComplete;
                        imgurl = await ref.getDownloadURL();
                        print("Image URL: " + imgurl);
                        auth
                            .createUserWithEmailAndPassword(
                                email: _email.text, password: _password.text)
                            .then((value) async {
                          final FirebaseUser user = await auth.currentUser();
                          String uid = user.uid;
                          Firestore.instance
                              .collection("users")
                              .document(uid)
                              .setData({
                            "age": _age.text,
                            "name": _name.text,
                            "phone": _phoneno.text,
                            "profile_pic": imgurl,
                            "isseen": true,
                          });
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
                                  'SignUp ',
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
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
