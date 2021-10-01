import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/home.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/sigin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_font/native_font.dart';

class siginin extends StatefulWidget {
  const siginin({Key? key}) : super(key: key);

  @override
  _sigininState createState() => _sigininState();
}

class _sigininState extends State<siginin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController refcode = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isLoading = false;

  signup(refcode, phone, password) async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'ref_code':  '',
      'phone': phone,
      'password': password,
    };
    final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/user_signup.php',
        ),
        body: data);

    if (response.statusCode == 200) {
      var datas = (jsonDecode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      print(datas);
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(datas['result'].toString()),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => mainpage()),
        (route) => false,
      );
      datas['result'].toString().contains(' This Phone is already registered!')
          ? null
          : datas;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,

        body: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 230,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/discountlogo.png',
                        height: 70,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Discound Hub Get Discount on',
                        style: nativeFontTextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(22, 97, 207, 10),
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        'Everything',
                        style: nativeFontTextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(22, 97, 207, 10),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Column(
                children: [
                  Text(
                    'Signup',
                    style: nativeFontTextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(22, 97, 207, 10),
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Text(
                  //   'Enter your information ',
                  //   style: TextStyle(
                  //       color: Colors.grey,
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.bold,fontFamily: 'sans-serif-condensed'),
                  // ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        validator: (val) =>
                            !val!.contains('+92') ? 'add +92' : null,
                        onSaved: (val) => val = phone.text,
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        decoration: InputDecoration(
                            hintStyle: nativeFontTextStyle(
                              fontFamily: 'Roboto',
                            ),
                            prefixIcon: Icon(CupertinoIcons.phone,
                                color: Color.fromRGBO(22, 97, 207, 10)),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Phone no (+92)',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 2,
                  // ),
                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        validator: (String? msg) {
                          if (msg!.isEmpty) {
                            return 'enter password';
                          }
                        },
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                            hintStyle: nativeFontTextStyle(
                              fontFamily: 'Roboto',
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: Color.fromRGBO(22, 97, 207, 10),
                            ),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter your password',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 2,
                  // ),
                  // Container(
                  //   width: 220,
                  //   child: Padding(
                  //     // padding: const EdgeInsets.all(14.0),
                  //     padding: const EdgeInsets.all(0.0),
                  //     child: TextFormField(
                  //       keyboardType: TextInputType.number,
                  //       controller: refcode,
                  //       decoration: InputDecoration(
                  //           hintStyle: nativeFontTextStyle(
                  //             fontFamily: 'Roboto',
                  //           ),
                  //           prefixStyle: TextStyle(color: Colors.grey),
                  //           hintText: ' Refrral Code (Optional)',
                  //           enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //               borderSide: BorderSide(
                  //                   color: Color.fromRGBO(22, 97, 207, 10))),
                  //           focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //               borderSide: BorderSide(
                  //                   color: Color.fromRGBO(22, 97, 207, 10))),
                  //           errorBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //               borderSide: BorderSide(color: Colors.red)),
                  //           focusedErrorBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //               borderSide: BorderSide(color: Colors.red))),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  _isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.deepPurpleAccent,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(22, 97, 207, 10)),
                        )
                      : Container(
                          height: 40,
                          width: 120,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color.fromRGBO(22, 97, 207, 10),
                              child: Text(
                                'SIGNUP',
                                style: nativeFontTextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (formGlobalKey.currentState!.validate() &&
                                    phone.text.length == 13) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  return signup(
                                      refcode.text, phone.text, password.text);
                                } else if (phone.text.length != 13) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  _scaffoldKey.currentState!
                                      .showSnackBar(SnackBar(
                                    content: Text('enter valid number'),
                                    backgroundColor: Colors.red,
                                  ));
                                } else
                                  setState(() {
                                    _isLoading = false;
                                  });
                                (_scaffoldKey.currentState!
                                    .showSnackBar(SnackBar(
                                  content: Text('error occured'),
                                  backgroundColor: Colors.red,
                                )));
                              }),
                        ),
                ],
              ),
            ]),
          ),
        ));
  }
}
