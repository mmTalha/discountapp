import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/home.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_font/native_font.dart';
import 'package:google_fonts/google_fonts.dart';

class siginup extends StatefulWidget {
  const siginup({Key? key}) : super(key: key);

  @override
  _siginupState createState() => _siginupState();
}

class _siginupState extends State<siginup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController phone1 = TextEditingController();
  final TextEditingController password1 = TextEditingController();
  var result;

  signin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/user_login.php?phone=${phone1.text}&password=${password1.text}',
        ),
      );

      if (response.statusCode == 200) {
        var datas = (jsonDecode(response.body));
        print(datas);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text('${datas['result']}'),
          backgroundColor: Colors.red,
        ));
        var crdentials = datas['result'];
        print(crdentials);
        setState(() {
          _isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => mainpage()),
          (route) => false,
        );

        return datas;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return 'nothing happend';
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
                decoration: BoxDecoration(color: Colors.white10),
                width: MediaQuery.of(context).size.width,
                height: 250,
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
                    'Signin',
                    style: nativeFontTextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(22, 97, 207, 10),
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  // Text(
                  //   'Enter your password and phone number',
                  //   style: TextStyle(
                  //       color: Colors.grey,
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.bold, fontFamily: 'sans-serif-condensed'),
                  // ),

                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phone1,
                        validator: (val) =>
                            !val!.contains('+92') ? 'add +92' : null,
                        onSaved: (val) => val = phone1.text,
                        decoration: InputDecoration(
                            hintStyle: nativeFontTextStyle(
                              fontFamily: 'Roboto',
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.person,
                              color: Color.fromRGBO(22, 97, 207, 10),
                            ),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Phone no (+92)',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(22, 97, 207, 10),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(22, 97, 207, 10),
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),

                  Container(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: password1,
                        obscureText: true,
                        validator: (String? msg) {
                          if (msg!.isEmpty) {
                            return 'enter password';
                          }
                        },
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
                                  color: Color.fromRGBO(22, 97, 207, 10),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(22, 97, 207, 10),
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
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
                              'SIGNIN',
                              style: nativeFontTextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (formGlobalKey.currentState!.validate() &&
                                  phone1.text.length == 13) {
                                return signin();
                              } else if (phone1.text.length != 13) {
                                _scaffoldKey.currentState!
                                    .showSnackBar(SnackBar(
                                  content: Text('enter valid number'),
                                  backgroundColor: Colors.red,
                                ));
                              } else
                                (_scaffoldKey.currentState!
                                    .showSnackBar(SnackBar(
                                  content: Text('error occured'),
                                  backgroundColor: Colors.red,
                                )));
                            },
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Not a Member yet?',
                            style: TextStyle(
                                fontFamily: 'sans-serif-condensed',
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => siginin()),
                              );
                            },
                            child: Text(
                              'Register',
                              style: nativeFontTextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
